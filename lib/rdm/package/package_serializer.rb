module Rdm
  class PackageSerializer
    class << self
      def serialize(package)
        groups = collect_groups(package)
        {
          "name"        => package.name,
          "description" => package.description,
          "version"     => package.version,
          "groups"      => groups
        }
      end

      def collect_for_group(package, group=nil)
        res = {
          "local_dependencies"    => package.local_dependencies(group, true),
          "external_dependencies" => package.external_dependencies(group, true),
          "file_dependencies"     => package.file_dependencies(group, true),
          "config_dependencies"   => package.config_dependencies(group, true),
        }
        res.each do |k,v|
          res.delete(k) if v == []
        end
        res
      end

      private

      def collect_groups(package)
        groups_names = package.groups

        groups_names.inject({}) {|acc, group|
          acc[group] = collect_for_group(package, group)
          acc
        }
      end
    end
  end
end
