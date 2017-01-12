require 'spec_helper'

describe 'Rdm::DependenciesResolver' do
  include SetupHelper
  let(:example_path) do
    example_src
  end
  let(:package_path) do
    File.join(example_path, 'domain/core/Package.rb')
  end

  let(:metadata_fetcher) { Rdm::MetadataFetcher.new(package_path) }

  let(:resolver_server) { Rdm::DependenciesResolver.new('server', metadata_fetcher: metadata_fetcher) }
  let(:resolver_core) { Rdm::DependenciesResolver.new('core', metadata_fetcher: metadata_fetcher) }
  context 'within example project' do
    it do
      expect(resolver_server.resolve).to eq(%w(server web core repository))
      expect(resolver_core.resolve).to eq(%w(core repository))
    end
  end
end
