class Rdm::Package
  DEFAULT_GROUP = 'default'.freeze

  attr_accessor :metadata, :local_dependencies, :external_dependencies, :file_dependencies, :config_dependencies, :path

  def local_dependencies(group = nil, exclusive = false)
    fetch_dependencies(@local_dependencies || {}, group, exclusive)
  end

  def external_dependencies(group = nil, exclusive = false)
    fetch_dependencies(@external_dependencies || {}, group, exclusive)
  end

  def file_dependencies(group = nil, exclusive = false)
    fetch_dependencies(@file_dependencies || {}, group, exclusive)
  end

  def config_dependencies(group = nil, exclusive = false)
    fetch_dependencies(@config_dependencies || {}, group, exclusive)
  end

  # Import local dependency, e.g another package
  def import(dependency)
    @local_dependencies ||= {}
    @local_dependencies[current_group] ||= []
    @local_dependencies[current_group] << dependency
  end

  # General ruby requires, e.g. require another gem
  def require(dependency)
    @external_dependencies ||= {}
    @external_dependencies[current_group] ||= []
    @external_dependencies[current_group] << dependency
  end

  # Require file relative to package, e.g. require root file
  def require_file(file)
    @file_dependencies ||= {}
    @file_dependencies[current_group] ||= []
    @file_dependencies[current_group] << file
  end

  # Import config dependency
  def import_config(dependency)
    @config_dependencies ||= {}
    @config_dependencies[current_group] ||= []
    @config_dependencies[current_group] << dependency
  end

  def package
    yield
  end

  def dependency(group = nil)
    @current_group = group ? group.to_s : nil
    yield
    @current_group = nil
  end

  def source(value = nil)
    exec_metadata :source, value
  end

  def name(value = nil)
    exec_metadata :name, value
  end

  def version(value = nil)
    exec_metadata :version, value
  end

  def description(value = nil)
    exec_metadata :description, value
  end

  def groups
    groups_hash.keys
  end

  private

  def groups_hash
    @groups_hash ||= {}
  end

  def current_group
    a = @current_group || DEFAULT_GROUP
    groups_hash[a] = true
    a
  end

  def fetch_dependencies(groups, group, exclusive = false)
    deps = (groups[DEFAULT_GROUP] || [])
    case group
      when DEFAULT_GROUP, nil
        deps
      else
        return (groups[group.to_s] || []) if exclusive
        deps + (groups[group.to_s] || [])
    end
  end

  def exec_metadata(key, value)
    if value.nil?
      @metadata[key]
    else
      @metadata ||= {}
      @metadata[key] = value
    end
  end
end
