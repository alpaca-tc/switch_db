require 'tempfile'

RSpec.describe SwitchDb::ReferenceSet do
  describe 'ClassMethods' do
    describe '.parse_reference_set!' do
      subject(:reference_set) { described_class.load_file(tempfile.path) }

      let(:tempfile) do
        Tempfile.new.tap do |file|
          file.write(<<~CONTENT)
            :references:
            - :name: name
              :database_names:
              - db1
              - db2
          CONTENT

          file.flush
        end
      end

      it { is_expected.to be_a(described_class) }

      it 'parses configuration file' do
        expect(reference_set.references).to be_key('name')
        expect(reference_set.references['name'].name).to eq('name')
        expect(reference_set.references['name'].database_names).to eq(%w[db1 db2])
      end
    end
  end

  describe 'InstanceMethods' do
    let(:instance) { described_class.new(configuration_path) }
    let(:configuration_path) { tmp_dir.join('configuration.yml') }

    describe '#add_reference' do
      subject { instance.add_reference(reference) }
      let(:reference) { SwitchDb::Reference.new(name: 'name') }

      it 'adds reference to reference_set' do
        expect { subject }.to change(instance.references, :size).from(0).to(1)
      end
    end

    describe '#remove_reference' do
      subject { instance.remove_reference(reference) }
      let(:reference) { SwitchDb::Reference.new(name: 'name') }

      before do
        instance.add_reference(reference)
      end

      it 'removes reference to reference_set' do
        expect { subject }.to change(instance.references, :size).from(1).to(0)
      end
    end

    describe '#write_reference_set' do
      subject { instance.write_reference_set }

      def delete_configuration_path
        FileUtils.rm_rf(instance.configuration_path)
      end

      before do
        delete_configuration_path
      end

      after do
        delete_configuration_path
      end

      it 'write references to configuration_path' do
        expect { subject }.to change {
          File.exist?(instance.configuration_path)
        }.from(false).to(true)
      end
    end
  end
end
