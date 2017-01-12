module Rdm
  # will generate an additional non-ruby version for source / package
  # useful for situations where you need to communicate the dependency graph of packages to non-Ruby software
  # like CI (continuous integration) and such
  class PlainSpecGenerator
    require 'yaml'
    SOURCE_FILE  = 'Rdm.packages.yml'.freeze
    PACKAGE_FILE = 'Package.yml'.freeze

    attr_accessor :source
    def initialize(source)
      @source = source
    end

    def run
      generate_source
      generate_packages
    end

    def generate_source
      path    = File.join(source.root_path, SOURCE_FILE)
      data    = source_serializer.serialize(source)
      content = YAML.dump(data)
      File.write(path, content)
    end

    def generate_packages
      source.packages.values.each do |package|
        generate_package(package)
      end
    end

    def generate_package(package)
      path    = File.join(package.path, PACKAGE_FILE)
      data    = package_serializer.serialize(package)
      content = YAML.dump(data)
      File.write(path, content)
    end

    def source_serializer
      Rdm::SourceSerializer
    end

    def package_serializer
      Rdm::PackageSerializer
    end
  end
end
