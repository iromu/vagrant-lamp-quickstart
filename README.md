Description
===========

This is a example of setting up a full Linux, Apache, Mysql and PHP stack inside a vagrant managed virtual machine. 

It creates a mysql database and populates it with sql deltas from src/sql dir. To connect use this data:

 * Address: 10.11.122.131
 * Mode: TCP/IP
 * User: quickstart
 * Password: quickstart


Requirements
============

Download Virtualbox [http://www.virtualbox.org/wiki/Downloads](http://www.virtualbox.org/wiki/Downloads)

Download vagrant latest binaries from [http://vagrantup.com](http://vagrantup.com)


Add base image
	
	$ vagrant box add lucid32 http://files.vagrantup.com/lucid32.box


Usage
=====


Execute this command inside src/vagrant dir

	$ vagrant up

Add to your /etc/hosts file

	10.11.122.131	www.quickstart.vm quickstart.vm

Point your browser to [http://quickstart.vm/](http://quickstart.vm/)

You should see a Hello World! message.

To inspect php info [http://quickstart.vm/phpinfo.php](http://quickstart.vm/phpinfo.php)
