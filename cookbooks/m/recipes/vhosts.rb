#
# Cookbook Name:: m
# Recipe:: vhosts
#
# Copyright (c) 2016 Vaibhav Gulati, All Rights Reserved.

include_recipe 'apache2'

package 'apache2'

service 'apache2' do
  supports :status => true, :restart => true, :reload => true
end

%w[/var/www/html/example1 /var/www/html/example2].each do |dir|
directory "#{dir}" do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end
end

%w[www.example1.com www.example2.com].each do |conf_name|
  template "#{node['apache']['dir']}/sites-available/#{conf_name}.conf" do
    source "#{conf_name}.conf.erb"
    owner 'root'
    group node['apache']['root_group']
    backup false
    mode '0644'
  end
  apache_site conf_name do
    enable true
  end
end

apache_site '000-default' do
  enable false
  notifies :restart, 'service[apache2]', :immediately
end
