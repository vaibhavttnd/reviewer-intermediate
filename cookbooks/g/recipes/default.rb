#
# Cookbook Name:: g
# Recipe:: default
#
# Copyright (c) 2016 Vaibhav Gulati, All Rights Reserved.



Chef.event_handler do
  on :converge_failed do
    puts "Ohai! converge failed."
  end
end

#if File.exist?('/tmp/mysql.txt')
execute 'mysql-install' do
command 'sudo apt-get install mysql-server -y'
end
#end
