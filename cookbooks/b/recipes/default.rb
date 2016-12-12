#
# Cookbook Name:: b
# Recipe:: default
#
# Copyright (c) 2016 Vaibhav Gulati, All Rights Reserved.



user_details = Chef::EncryptedDataBagItem.load("users", "user")

user "#{user_details['uname']}" do
  uid "#{user_details['uid']}"
  gid "#{user_details['gid']}"
  home "#{user_details['home']}"
  shell "#{user_details['shell']}"
  password "#{user_details['password']}"
  supports manage_home: true
end

group "#{user_details['gname']}" do
  members "#{user_details['uname']}"
  append true
  action :create
end
