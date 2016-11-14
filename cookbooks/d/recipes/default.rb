#
# Cookbook Name:: d
# Recipe:: default
#
# Copyright (c) 2016 Vaibhav Gulati, All Rights Reserved.


execute 'create-user-test' do
command 'useradd test'
not_if 'grep test /etc/passwd', :user => 'test'
end

execute 'update' do
command 'sudo apt-get update'
only_if { File.exist?('/tmp/update') }
end

if File.exist?('/tmp/mysql.txt')
execute 'mysql-install' do
command 'sudo apt-get install mysql-server -y'
end
end
