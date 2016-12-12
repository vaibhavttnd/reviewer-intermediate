default['filebeat']['version'] = '1.3.1'
default['filebeat']['release'] = '1'
default['filebeat']['disable_service'] = false
default['filebeat']['package_url'] = 'auto'
default['filebeat']['package_force_overwrite'] = true

default['filebeat']['notify_restart'] = true
default['filebeat']['windows'] = { 'base_dir' => 'C:/opt/filebeat' }
default['filebeat']['solaris'] = {
  'base_dir' => '/opt',
  'manifest_directory' => '/var/svc/manifest/application'
}

default['filebeat']['service']['init_style'] = 'init' # or runit
default['filebeat']['service']['retries'] = 0
default['filebeat']['service']['retry_delay'] = 2
