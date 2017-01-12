require 'spec_helper'

describe 'Rdm::PackageSerializer' do
  let(:fixtures_path) {
    File.join(File.expand_path("../../../", __FILE__), 'fixtures')
  }
  let(:package_path) {
    File.join(fixtures_path, "sample_prj/infrastructure/web/Package.rb")
  }
  let(:package) { Rdm::PackageParser.parse_file(package_path) }
  context '::serialize' do
    it {
      expected =
        {:name=>"web",
         :description=>"our web frontend",
         :version=>"1.0",
         :groups=>
          {:default=>
            {:local_dependencies=>["core"],
             :external_dependencies=>["active_support"],
             :file_dependencies=>["lib/web.rb"],
             :config_dependencies=>[]},
           :test=>
            {:local_dependencies=>["core", "test_factory"],
             :external_dependencies=>["active_support", "rspec"],
             :file_dependencies=>["lib/web.rb", "lib/spec.rb"],
             :config_dependencies=>[]}}}

      expect(Rdm::PackageSerializer.serialize(package)).to eq(expected)
    }
  end
end
