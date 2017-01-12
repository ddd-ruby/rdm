module Rdm
  SOURCE_FILENAME = 'Rdm.packages'.freeze
  PACKAGE_FILENAME = 'Package.rb'.freeze

  # Support
  require 'rdm/support/colorize'
  require 'rdm/support/render'
  require 'rdm/support/template'
  require 'rdm/version'

  # CLI part
  require 'rdm/cli/gen_package'
  require 'rdm/cli/init'
  require 'rdm/gen/concerns/template_handling'
  require 'rdm/gen/package'
  require 'rdm/gen/init'

  # Runtime part
  require 'rdm/config/config'
  require 'rdm/config/config_scope'
  require 'rdm/config/config_manager'
  require 'rdm/errors'
  require 'rdm/package/package'
  require 'rdm/package/package_importer'
  require 'rdm/package/package_parser'
  require 'rdm/package/package_serializer'

  require 'rdm/settings'
  require 'rdm/source/source'
  require 'rdm/source/source_parser'
  require 'rdm/source/source_locator'

  # Util
  require 'rdm/util/dependencies_resolver'
  require 'rdm/util/metadata_fetcher'

  class << self
    # Initialize current package using Package.rb
    def init(package_path, group = nil)
      Rdm::PackageImporter.import_file(package_path, group: group)
    end

    # Rdm's internal settings
    def settings
      @settings ||= Rdm::Settings.new
    end

    # Rdm's managed configuration
    def config
      @config ||= Rdm::ConfigManager.new
    end

    # Setup Rdm's internal settings
    def setup(&block)
      settings.instance_eval(&block) if block_given?
    end

    def root=(value)
      if @root && @root != value
        puts "Rdm has already been initialized and Rdm.root was set to #{@root}"
      end
      @root = value
    end

    attr_reader :root
  end
end
