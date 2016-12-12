filebeat Cookbook
================

[![Cookbook](http://img.shields.io/badge/cookbook-v0.4.2-green.svg)](https://github.com/vkhatri/chef-filebeat) [![Build Status](https://travis-ci.org/vkhatri/chef-filebeat.svg?branch=master)](https://travis-ci.org/vkhatri/chef-filebeat)

This is a [Chef] cookbook to manage [Filebeat].


>> For Production environment, always prefer the [most recent release](https://supermarket.chef.io/cookbooks/filebeat).


## Most Recent Release

```ruby
cookbook 'filebeat', '~> 0.4.2'
```

## From Git

```ruby
cookbook 'filebeat', github: 'vkhatri/chef-filebeat',  tag: 'v0.4.2'
```

## Repository

```
https://github.com/vkhatri/chef-filebeat
```

## Supported OS

This cookbook was tested on Windows, Amazon & Ubuntu Linux and expected to work on other RHEL platforms.

This also works on Solaris zones given a physical Solaris 11.2 server. For that, use the .kitchen.zone.yml file. Check usage at (https://github.com/criticalmass/kitchen-zone). You will need an url to a filebeat package that works on Solaris 11.2. Checkout Building-Filebeat-On-Solaris11.md for instructions to build a filebeat package.

## Major Changes

### v0.2.5
- Removed default output configuration attributes for `elasticsearch`, `logstash` and `file`
- Removed attributed `default['filebeat']['enable_localhost_output']` as default `output` attributes are disabled

## Cookbook Dependency

- windows
- apt
- yum


## Recipes

- `filebeat::attributes` - cookbook derived default attributes

- `filebeat::config` - configure filebeat

- `filebeat::default` - default recipe (use it for run_list)

- `filebeat::install_package` - install filebeat package for linux platform

- `filebeat::install_solaris` - install filebeat package for solaris platform

- `filebeat::install_windows` - install filebeat for windows platform


## LWRP filebeat_prospector

LWRP `filebeat_prospector` creates filebeat prospector configuration yaml file under directory `node['filebeat']['prospectors_dir']` with file name `prospector-#{resource_name}.yml`.


**LWRP example**

```ruby
filebeat_prospector 'messages' do
  paths ['/var/log/messages']
  document_type 'apache'
  ignore_older '24h'
  scan_frequency '15s'
  harvester_buffer_size 16384
  fields 'type' => 'apacheLogs'
end
```

**LWRP Options**

- *action* (optional)	- default :create, options: :create, :delete
- *paths* (optional, String)	- filebeat prospector configuration attribute
- *type* (optional, String)	- filebeat prospector configuration attribute
- *encoding* (optional, String)	- filebeat prospector configuration attribute
- *fields* (optional, Hash)	- filebeat prospector configuration attribute
- *fields_under_root* (optional, TrueClass/FalseClass)	- filebeat prospector configuration attribute
- *ignore_older* (optional, String)	- filebeat prospector configuration attribute
- *document_type* (optional, String)	- filebeat prospector configuration attribute
- *input_type* (optional, String)	- filebeat prospector configuration attribute
- *close_older* (optional, String)	- filebeat prospector configuration attribute
- *scan_frequency* (optional, String)	- filebeat prospector configuration attribute
- *harvester_buffer_size* (optional, Integer)	- filebeat prospector configuration attribute
- *tail_files* (optional, TrueClass/FalseClass)	- filebeat prospector configuration attribute
- *backoff* (optional, String)	- filebeat prospector configuration attribute
- *max_backoff* (optional, String)	- filebeat prospector configuration attribute
- *backoff_factor* (optional, Integer)	- filebeat prospector configuration attribute
- *force_close_files* (optional, TrueClass/FalseClass)	- filebeat prospector configuration attribute
- *include_lines* (optional, Array)	- A list of regular expressions to match the lines that you want Filebeat to include. Filebeat exports only the lines that match a regular expression in the list. By default, all lines are exported.
- *exclude_lines* (optional, Array)	- A list of regular expressions to match the lines that you want Filebeat to exclude. Filebeat drops any lines that match a regular expression in the list. By default, no lines are dropped.
- *max_bytes* (optional, Integer)	- filebeat prospector configuration attribute
- *multiline* (optional, Hash)	- Multiline configuration hash. Options: `pattern`: <regex pattern to match>, `negate`: [true/false], `match`: [before/after]
- *exclude_files* (optional, Array)	- A list of regular expressions to match the files that you want Filebeat prospector instance to exclude.
- *spool_size* (optional, Integer)	- ilebeat prospector configuration attribute
- *publish_async* (optional, TrueClass/FalseClass)	- filebeat prospector configuration attribute
- *idle_timeout* (optional, String)	- filebeat prospector configuration attribute
- *registry_file* (optional, String)	- filebeat prospector configuration attribute

## How to Add Filebeat Output via Node Attribute


### Redis Output

```json
  "default_attributes": {
    "filebeat": {
      "config": {
        "output": {
          "redis": {
            "enable": true,
            "host": "127.0.0.1",
            "port": 6379,
            "save_topology": false,
            "index": "filebeat",
            "db": 0,
            "db_topology": 1,
            "password": "",
            "timeout": 5,
            "reconnect_interval": 1
          }
        }
      }
    }
  }

```

### ElasticSearch Output

```json
  "default_attributes": {
    "filebeat": {
      "config": {
        "output": {
          "elasticsearch": {
            "enable": true,
            "hosts": ["127.0.0.1:9200"],
            "save_topology": false,
            "max_retries": 3,
            "bulk_max_size": 1000,
            "flush_interval": null,
            "protocol": "http",
            "username": null,
            "password": null,
            "index": "filebeat",
            "path": "/elasticsearch",
            "tls": {
              "certificate_authorities": ["/etc/ca.crt"],
              "certificate": "/etc/client.crt",
              "certificate_key": "/etc/client.key",
              "insecure": false
            }
          }
        }
      }
    }
  }

```

### Logstash Output

```json
  "default_attributes": {
    "filebeat": {
      "config": {
        "output": {
          "logstash": {
            "enable": true,
            "hosts": ["127.0.0.1:5000"],
            "loadbalance": true,
            "save_topology": false,
            "index": "filebeat",
            "tls": {
              "certificate_authorities": ["/etc/ca.crt"],
              "certificate": "/etc/client.crt",
              "certificate_key": "/etc/client.key",
              "insecure": false
            }
          }
        }
      }
    }
  }

```

### File Output

```json
  "default_attributes": {
    "filebeat": {
      "config": {
        "output": {
          "file": {
            "path": "/tmp/filebeat",
            "filename": "filebeat",
            "rotate_every_kb": 1000,
            "number_of_files": 7
          }
        }
      }
    }
  }

```

## How to Add Filebeat Prospectors via Node Attribute

Individual prospectors configuration file can be added using attribute `default['filebeat']['prospectors']`. Each prospector configuration will
be created as a different yaml file under `default['filebeat']['prospector_dir']` with prefix `prospector-`

```json
  "default_attributes": {
    "filebeat": {
      "prospectors": {
        "system_logs": {
          "filebeat": {
            "prospectors": [
              {
                "paths": [
                  "/var/log/messages",
                  "/var/log/syslog"
                ],
                "type": "log",
                "fields": {
                  "type": "system_logs"
                }
              }
            ]
          }
        },
        "secure_logs": {
          "filebeat": {
            "prospectors": [
              {
                "paths": [
                  "/var/log/secure",
                  "/var/log/auth.log"
                ],
                "type": "log",
                "fields": {
                  "type": "secure_logs"
                }
              }
            ]
          }
        },
        "apache_logs": {
          "filebeat": {
            "prospectors": [
              {
                "paths": [
                  "/var/log/apache/*.log"
                ],
                "type": "log",
                "ignore_older": "24h",
                "scan_frequency": "15s",
                "harvester_buffer_size": 16384,
                "fields": {
                  "type": "apache_logs"
                }
              }
            ]
          }
        }
      }
    }
  }

```


Above configuration will create three different prospector files - `prospector-system_logs.yml, prospector-secure_logs.yml and prospector-apache_logs.yml`


## Core Attributes


* `default['filebeat']['version']` (default: `1.3.1`): filebeat version

* `default['filebeat']['release']` (default: `1`): filebeat release for yum package

* `default['filebeat']['service']['init_style']` (default: `init`): filebeat service init system, options: init, runit

* `default['filebeat']['package_url']` (default: `auto`): package url for windows installation

* `default['filebeat']['conf_dir']` (default: `/etc/filebeat`): filebeat yaml configuration file directory

* `default['filebeat']['conf_file']` (default: `/etc/filebeat/filebeat.yml`): filebeat configuration file

* `default['filebeat']['notify_restart']` (default: `true`): whether to restart filebeat service on configuration file change

* `default['filebeat']['disable_service']` (default: `false`): whether to stop and disable filebeat service

* `default['filebeat']['prospectors_dir']` (default: `/etc/filebeat/conf.d`): prospectors configuration file directory

* `default['filebeat']['prospectors']` (default: `{}`): prospectors configuration file


## Configuration File filebeat.yml Attributes

* `default['filebeat']['config']['filebeat']['prospectors']` (default: `[]`): filebeat interface device name

* `default['filebeat']['config']['filebeat']['registry_file']` (default: `/var/lib/filebeat/registry`): filebeat services to capture packets

* `default['filebeat']['config']['filebeat']['config_dir']` (default: `node['filebeat']['prospectors_dir']`): filebeat prospectors configuration files folder


* `default['filebeat']['config']['output']` (default: `{}`): configure elasticsearch. logstash, file etc.  output

For more attribute info, visit below links:

https://github.com/elastic/filebeat/blob/master/etc/filebeat.yml


## Filebeat YUM/APT Repository Attributes

* `default['filebeat']['yum']['description']` (default: ``): beats yum reporitory attribute

* `default['filebeat']['yum']['gpgcheck']` (default: `true`): beats yum reporitory attribute

* `default['filebeat']['yum']['enabled']` (default: `true`): beats yum reporitory attribute

* `default['filebeat']['yum']['baseurl']` (default: `https://packages.elastic.co/beats/yum/el/$basearch`): beatsyum reporitory attribute

* `default['filebeat']['yum']['gpgkey']` (default: `https://packages.elasticsearch.org/GPG-KEY-elasticsearch`): beats yum reporitory attribute

* `default['filebeat']['yum']['metadata_expire']` (default: `3h`): beats yum reporitory attribute

* `default['filebeat']['yum']['action']` (default: `:create`): beats yum reporitory attribute


* `default['filebeat']['apt']['description']` (default: `calculated`): beats apt reporitory attribute

* `default['filebeat']['apt']['components']` (default: `['stable', 'main']`): beats apt reporitory attribute

* `default['filebeat']['apt']['uri']` (default: `https://packages.elastic.co/beats/apt`): beats apt reporitory attribute

* `default['filebeat']['apt']['key']` (default: `http://packages.elasticsearch.org/GPG-KEY-elasticsearch`): beats apt reporitory attribute

* `default['filebeat']['apt']['action']` (default: `:add`): filebeat apt reporitory attribute


## Other Attributes

* `default['filebeat']['service']['retries']` (default: `:0`): filebeat service resource attribute

* `default['filebeat']['service']['retry_delay']` (default: `:2`): filebeat service resource attribute


## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests (`rake & rake knife`), ensuring they all pass
6. Write new resource/attribute description to `README.md`
7. Write description about changes to PR
8. Submit a Pull Request using Github


## Copyright & License

Authors:: Virender Khatri and [Contributors]

<pre>
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
</pre>


[Chef]: https://www.chef.io/
[Filebeat]: https://www.elastic.co/products/beats/filebeat
[Contributors]: https://github.com/vkhatri/chef-filebeat/graphs/contributors
