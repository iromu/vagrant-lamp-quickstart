gem_package "mysql" do
  action :install
end

mysql_connection_info = {:host => "localhost", :username => 'root', :password => node[:mysql][:server_root_password]}

mysql_database node[:quickstart][:db][:database] do
  connection mysql_connection_info
  action :create
end

mysql_database_user node[:quickstart][:db][:user] do
  connection mysql_connection_info
  password node[:quickstart][:db][:password]
  host '%'
  privileges ['all privileges']
  action :grant
end

mysql_database node[:quickstart][:db][:database] do
  connection mysql_connection_info
  sql "flush privileges"
  action :query
end

ruby_block "Load database deltas" do
  block do
    require 'rubygems'
    Gem.clear_paths
    require 'mysql'

    mysql = Mysql.new("localhost", "root", node[:mysql][:server_root_password])
    mysql.query("use  `#{node[:quickstart][:db][:database]}`")

    applied = []
    if mysql.query("show tables where Tables_in_#{node[:quickstart][:db][:database]} = 'changelog'").num_rows>0
      res=mysql.query("select delta from changelog")
      while row = res.fetch_row do
        applied << row[0]
      end
      res.free
    end

    ls = Mixlib::ShellOut.new("ls -1 #{node[:quickstart][:db][:deltas]}")
    ls.run_command

    deltas = ls.stdout.lines.map { |delta| delta.chomp }

    if !(pending = deltas - applied).empty?
      pending.sort.each { |delta|
        Chef::Log.info "Running #{delta}"
        Mixlib::ShellOut.new("mysql #{node[:quickstart][:db][:database]} -u #{node[:quickstart][:db][:user]} --password=#{node[:quickstart][:db][:password]} < #{node[:quickstart][:db][:deltas]}/#{delta}").run_command

        mysql.query("INSERT INTO changelog VALUES (null, '#{delta}', NOW(), 'chef_solo')")
      }
    end
  end
end
