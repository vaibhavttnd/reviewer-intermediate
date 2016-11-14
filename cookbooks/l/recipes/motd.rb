#
# Cookbook Name:: l
# Recipe:: motd
#
# Copyright (c) 2016 Vaibhav Gulati, All Rights Reserved.


template "/etc/motd.sh" do
    source "motd.sh.erb"
    owner 'root'
    mode '0644'
end
