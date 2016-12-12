#
# Cookbook Name:: elk-reviewer
# Recipe:: filebeat_install
#
# Copyright (c) 2016 vaibhav.gulati@tothenew.com, All Rights Reserved.

include_recipe 'filebeat'

node.override['filebeat']['config']['filebeat']['idle_timeout'] =  '5s'
node.override['filebeat']['config']['output']['elasticsearch']['index'] = 'chef-filebeat'
node.override['filebeat']['config']['output']['elasticsearch']['hosts'] ='127.0.0.1' #change it accordingly
syslog = {
    'paths' => ["/var/log/syslog"],
    'input_type' => "syslog",
    'fields' => {  'logtype' => "syslog"  },
    'document_type' => "syslog",
    'fields_under_root' => true
}
node.override['filebeat']['prospectors']['access']['filebeat']['prospectors'] = [syslog]

