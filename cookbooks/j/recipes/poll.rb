#
# Cookbook Name:: j
# Recipe:: poll
#
# Copyright (c) 2016 vaibhav.gulati@tothenew.com, All Rights Reserved.


cron_d 'poll-chef-server' do
  minute  20
  hour    0
  command 'sudo chef-client'
  user    'root'
end
