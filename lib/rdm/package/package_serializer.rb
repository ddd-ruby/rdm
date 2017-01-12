module Rdm
  class PackageSerializer
    class << self
      def serialize(package)
        groups = collect_groups(package)
        {
          name:        package.name,
          description: package.description,
          version:     package.version,
          groups:      groups
        }
      end

      def collect_for_group(package, group=nil)
        {
          local_dependencies:    package.local_dependencies(group),
          external_dependencies: package.external_dependencies(group),
          file_dependencies:     package.file_dependencies(group),
          config_dependencies:   package.config_dependencies(group),
        }
      end

      private

      def collect_groups(package)
        groups_names = package.groups

        groups_names.inject({}) {|acc, group|
          acc[group_key(group)] = collect_for_group(package, group)
          acc
        }
      end

      def group_key(group)
        group == Rdm::Package::DEFAULT_GROUP ? :default : group.to_sym
      end
    end
  end
end
