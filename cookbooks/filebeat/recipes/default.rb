#
# Cookbook Name:: filebeat
# Recipe:: default
#
# Copyright 2015, Virender Khatri
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'filebeat::attributes'

include_recipe 'yum-plugin-versionlock::default' if node['platform_family'] == 'rhel'

# install filebeat
case node['platform']
when 'windows'
  include_recipe 'filebeat::install_windows'
when 'solaris2'
  include_recipe 'filebeat::install_solaris'
else
  include_recipe 'filebeat::install_package'
end

# configure filebeat
include_recipe 'filebeat::config'
