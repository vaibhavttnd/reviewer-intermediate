class Chef
  class Provider
    # provides filebeat_prospector
    class FilebeatProspector < Chef::Provider::LWRPBase
      provides :filebeat_prospector if respond_to?(:provides)

      def whyrun_supported?
        true
      end

      action :create do
        new_resource.updated_by_last_action(prospector_file)
      end

      action :delete do
        new_resource.updated_by_last_action(prospector_file)
      end

      protected

      def prospector_file
        # When action is set it is an array.  Using is_a because symbols respond to []
        action = if new_resource.action.is_a?(Array)
                   raise("Unexpected number of actions: #{new_resource.action}") if new_resource.action.length != 1
                   new_resource.action[0]
                 else
                   new_resource.action
                 end

        content = {}
        if action == :create
          content['paths'] = new_resource.paths if new_resource.paths
          content['type'] = new_resource.type if new_resource.type
          content['encoding'] = new_resource.encoding if new_resource.encoding
          content['fields_under_root'] = new_resource.fields_under_root if new_resource.fields_under_root
          content['ignore_older'] = new_resource.ignore_older if new_resource.ignore_older
          content['document_type'] = new_resource.document_type if new_resource.document_type
          content['input_type'] = new_resource.input_type if new_resource.input_type
          content['close_older'] = new_resource.close_older if new_resource.close_older
          content['scan_frequency'] = new_resource.scan_frequency if new_resource.scan_frequency
          content['harvester_buffer_size'] = new_resource.harvester_buffer_size if new_resource.harvester_buffer_size
          content['tail_files'] = new_resource.tail_files if new_resource.tail_files
          content['backoff'] = new_resource.backoff if new_resource.backoff
          content['max_backoff'] = new_resource.max_backoff if new_resource.max_backoff
          content['backoff_factor'] = new_resource.backoff_factor if new_resource.backoff_factor
          content['force_close_files'] = new_resource.force_close_files if new_resource.force_close_files
          content['fields'] = new_resource.fields if new_resource.fields
          content['include_lines'] = new_resource.include_lines if new_resource.include_lines
          content['exclude_lines'] = new_resource.exclude_lines if new_resource.exclude_lines
          content['max_bytes'] = new_resource.max_bytes if new_resource.max_bytes
          content['multiline'] = new_resource.multiline if new_resource.multiline
          content['exclude_files'] = new_resource.exclude_files if new_resource.exclude_files
          content['spool_size'] = new_resource.exclude_files if new_resource.exclude_files
          content['publish_async'] = new_resource.publish_async if new_resource.publish_async
          content['idle_timeout'] = new_resource.idle_timeout if new_resource.idle_timeout
          content['registry_file'] = new_resource.registry_file if new_resource.registry_file
        end

        file_content = { 'filebeat' => { 'prospectors' => [content] } }.to_yaml

        t = file "prospector_#{new_resource.name}" do
          path ::File.join(node['filebeat']['prospectors_dir'], "prospector-#{new_resource.name}.yml")
          content file_content
          notifies :restart, 'service[filebeat]'
          action action
        end
        t.updated?
      end
    end
  end
end
