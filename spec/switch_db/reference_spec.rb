RSpec.describe SwitchDb::Reference do
  describe 'InstanceMethods' do
    let(:instance) { described_class.new(name: name, database_names: database_names) }

    let(:name) { 'name' }
    let(:database_names) { %w[db1 db2] }

    describe '#path' do
      subject { instance.path }
      it { is_expected.to eq(name) }
    end

    describe '#full_path' do
      subject { instance.full_path.to_s }
      it { is_expected.to start_with(SwitchDb.configuration.cache_dir.to_s) }
      it { is_expected.to end_with(name) }
    end

    describe '#database_paths' do
      subject { instance.database_paths }

      let(:expected_database_paths) do
        [
          SwitchDb.configuration.cache_dir.join('name', 'db1.sql'),
          SwitchDb.configuration.cache_dir.join('name', 'db2.sql'),
        ]
      end

      it { is_expected.to eq(expected_database_paths) }
    end

    describe '#to_h' do
      subject { instance.to_h }
      it { is_expected.to eq(name: 'name', database_names: %w(db1 db2)) }
    end
  end
end
