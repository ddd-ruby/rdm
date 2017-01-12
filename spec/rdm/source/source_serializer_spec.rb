require 'spec_helper'

describe 'Rdm::SourceSerializer' do
  let(:source_parser) { Rdm::SourceParser }
  let(:fixtures_path) {
    File.join(File.expand_path("../../../../", __FILE__), 'example')
  }
  let(:source_path) {
    File.join(fixtures_path, "Rdm.packages")
  }
  before :each do
    @source = source_parser.read_and_init_source(source_path)
  end
  context '::serialize' do
    it {
      expected =
        {"packages"=>
          [{"name"=>"server", "path"=>"server"},
           {"name"=>"web", "path"=>"application/web"},
           {"name"=>"core", "path"=>"domain/core"},
           {"name"=>"repository", "path"=>"infrastructure/repository"}],
         "configs"=>
          [{"name"=>"database",
            "default_path"=>"configs/database/default.yml",
            "role_path"=>"configs/database/production.yml"},
           {"name"=>"app",
            "default_path"=>"configs/app/default.yml",
            "role_path"=>"configs/app/production.yml"}]}
      res = Rdm::SourceSerializer.serialize(@source)
      expect(res).to eq(expected)
    }
  end
end
