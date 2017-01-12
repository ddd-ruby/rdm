require 'spec_helper'

describe 'Rdm::MetadataFetcher' do
  context 'in example project' do
    let(:example_path) do
      File.join(File.expand_path('../../../', __FILE__), 'example')
    end
    let(:package_path) do
      File.join(example_path, 'domain/core/Package.rb')
    end
    let(:fetcher) { Rdm::MetadataFetcher.new(package_path) }

    context 'root_dir' do
      it do
        expect(fetcher.root_dir).to match(Regexp.new('/example$'))
      end
    end

    context 'metadata' do
      it 'works for web' do
        meta = fetcher.metadata('web')
        expect(meta.name).to eq('web')
        expect(meta.version).to eq('1.0')
        expect(meta.local_dependencies).to eq(['core'])
        expect(meta.external_dependencies(:test)).to eq([])
        expect(meta.file_dependencies).to eq([])
      end

      it 'works for core' do
        meta = fetcher.metadata('core')
        expect(meta.name).to eq('core')
        expect(meta.version).to eq('1.0')
        expect(meta.local_dependencies).to eq(['repository'])
        expect(meta.external_dependencies(:test)).to eq([])
        expect(meta.file_dependencies).to eq([])
      end
    end
  end
end
