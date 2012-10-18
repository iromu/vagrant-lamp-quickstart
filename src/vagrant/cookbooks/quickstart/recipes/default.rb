apache_site "default" do
  enable false
end

web_app "quickstart.vm" do
  server_name "quickstart.vm"
  server_aliases "www.quickstart.vm"
  docroot "/var/www/quickstart/src/php/public"
end

php_pear "xdebug" do
  action :install
end

template "/etc/php5/apache2/conf.d/xdebug.ini" do
  source "xdebug.ini.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, resources("service[apache2]"), :delayed
end

template "/etc/php5/apache2/php.ini" do
  source "php.ini.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, resources("service[apache2]"), :delayed
end
