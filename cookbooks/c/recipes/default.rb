#
# Cookbook Name:: c
# Recipe:: default
#
# Copyright (c) 2016 vaibhav.gulati@tothenew.com, All Rights Reserved.


node.default['test']="recipe"
node.force_default['test']="force-default-recipe"
node.normal['test']='normal-attribute-recipe'
node.override['test']='override-attribute-recipe'
node.force_override['test']="override-attribute-recipe"

execute 'apache_configtest' do
  command "touch /home/vagrant/#{node['test']}"
end
