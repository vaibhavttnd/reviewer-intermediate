#
# Cookbook Name:: elk-reviewer
# Recipe:: default
#
# Copyright (c) 2016 vaibhav.gulati@tothenew.com, All Rights Reserved.

include_recipe 'elk-reviewer::elk_install'
include_recipe 'elk-reviewer::filebeat_install'
