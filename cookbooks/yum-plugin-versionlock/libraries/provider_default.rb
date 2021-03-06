class Chef
  class Provider
    # provides yum_version_lock
    class YumVersionLock < Chef::Provider::LWRPBase
      provides :yum_version_lock if respond_to?(:provides)

      def whyrun_supported?
        true
      end

      action :add do
        new_resource.updated_by_last_action(set_yum_version_lock)
      end

      action :update do
        new_resource.updated_by_last_action(set_yum_version_lock)
      end

      action :remove do
        new_resource.updated_by_last_action(set_yum_version_lock)
      end

      protected

      def set_yum_version_lock
        # EPOCH:NAME-VERSION-RELEASE.ARCH
        version_string = "#{new_resource.epoch}:#{new_resource.package}-#{new_resource.version}-#{new_resource.release}.#{new_resource.arch}"
        resource_action = new_resource.action.is_a?(Array) ? new_resource.action.first.to_s : new_resource.action.to_s

        ruby_block "#{resource_action} yum_version_lock #{version_string}" do
          block do
            fe = Chef::Util::FileEdit.new(node['yum-plugin-versionlock']['locklist'])
            case resource_action
            when 'add'
              fe.insert_line_if_no_match(/#{version_string}/, version_string)
            when 'update'
              fe.search_file_replace_line(/^[0-9]+:#{new_resource.package}-.+-.+\./, version_string)
              fe.insert_line_if_no_match(/#{version_string}/, version_string)
            when 'remove'
              fe.search_file_delete_line(/#{version_string}/)
            end
            fe.write_file
          end
        end
      end
    end
  end
end
