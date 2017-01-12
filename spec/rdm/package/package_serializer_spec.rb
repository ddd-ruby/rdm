require 'spec_helper'

describe 'Rdm::PackageSerializer' do
  include SetupHelper
  let(:package_path) {
    File.join(fixtures_path, "sample_prj/infrastructure/web/Package.rb")
  }
  let(:package) { Rdm::PackageParser.parse_file(package_path) }
  context '::serialize' do
    it {
      expected =
        {"name"=>"web",
         "description"=>"our web frontend",
         "version"=>"1.0",
         "groups"=>
          {"default"=>
            {"local_dependencies"=>["core"],
             "external_dependencies"=>["active_support"],
             "file_dependencies"=>["lib/web.rb"]},
           "test"=>
            {"local_dependencies"=>["test_factory"],
             "external_dependencies"=>["rspec"],
             "file_dependencies"=>["lib/spec.rb"]}}}
      res = Rdm::PackageSerializer.serialize(package)
      expect(res).to eq(expected)
    }
  end
end
