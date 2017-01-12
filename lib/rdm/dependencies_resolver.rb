module Rdm
  class DependenciesResolver
    attr_accessor :name, :dependent_packages

    def initialize(name, metadata_fetcher:)
      @name               = name
      @parsed             = false
      @dependent_packages = []
      @metadata_fetcher   = metadata_fetcher
    end

    def resolve
      @dependent_packages = []
      recursive_find_dependencies(name)
      dependent_packages
    end

    private

    attr_reader :metadata_fetcher

    def recursive_find_dependencies(package_name)
      return if dependent_packages.include?(package_name)
      dependent_packages.push(package_name)
      package = metadata(package_name)
      package.local_dependencies.each do |name|
        recursive_find_dependencies(name)
      end
    end

    def metadata(name)
      metadata_fetcher.metadata(name)
    end
  end
end
