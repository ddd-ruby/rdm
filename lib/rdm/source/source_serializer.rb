module Rdm
  class SourceSerializer
    class << self
      def serialize(source)
        {
          'packages' => packages(source),
          'configs'  => configs(source.configs)
        }
      end

      private

      def packages(source)
        root = source.root_path
        source.packages.map do |k, v|
          {
            'name' => k,
            'path' => path(v.path, root)
          }
        end
      end

      def path(path, root)
        path.gsub(root + '/', '')
      end

      def configs(configs)
        configs.map do |k, v|
          {
            'name'         => k,
            'default_path' => v.default_path,
            'role_path'    => v.role_path
          }
        end
      end
    end
  end
end
