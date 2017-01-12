module Rdm
  # a helper class to get packages metadata
  class MetadataFetcher
    attr_accessor :path_in_hierarchy
    def initialize(path_in_hierarchy)
      @path_in_hierarchy = path_in_hierarchy
    end

    def metadata(package_name)
      packages_metadata.packages[package_name] || raise("Package: #{package_name} not present!")
    end

    def root_dir
      File.dirname(rdm_packages_file)
    end

    def packages_metadata
      @packages_metadata ||= Rdm::SourceParser.read_and_init_source(rdm_packages_file)
    end

    def rdm_packages_file
      @rdm_packages_file ||= Rdm::SourceLocator.locate(path_in_hierarchy)
    end
  end
end
