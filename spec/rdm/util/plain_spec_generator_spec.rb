require "spec_helper"

describe Rdm::PlainSpecGenerator do
  before :all do
    Rdm::Gen::Package.disable_logger!
  end
  include SetupHelper

  def generate_package!
    Rdm::Gen::Package.generate(
      current_dir: project_dir,
      package_name: "some",
      package_relative_path: "domain/some",
      skip_tests: false
    )
  end

  def ensure_exists(file)
    expect(File.exists?(file)).to be true
  end

  def ensure_content(file, content)
    expect(File.read(file)).to match(content)
  end

  let(:source_path){ File.join(project_dir, Rdm::SOURCE_FILENAME) }
  let(:source) { Rdm::SourceParser.read_and_init_source(source_path) }

  context "sample project" do
    before :all do
      fresh_project
      generate_package!
    end

    after :all do
      clean_tmp
    end

    it "has generated correct YAML files" do
      Rdm::PlainSpecGenerator.new(source).run
      FileUtils.cd(project_dir) do
        ensure_exists(Rdm::PlainSpecGenerator::SOURCE_FILE)
        ensure_content(Rdm::PlainSpecGenerator::SOURCE_FILE, "---\npackages:\n- name: server\n  path: server")
        ensure_exists("domain/some/Package.rb")
        ensure_exists("domain/some/Package.yml")
        ensure_content("domain/some/Package.yml", "---\nname: some\ndescription: \nversion: 1.0.0\ngroups: {}\n")
        ensure_content("domain/core/Package.yml", "---\nname: core\ndescription: \nversion: '1.0'\ngroups:\n  default:\n    local_dependencies:\n    - repository\n")
      end
    end
  end
end
