RSpec.describe SwitchDb::Configuration do
  describe 'InstanceMethods' do
    let(:instance) { described_class.new }

    describe '#reference_set_filename' do
      subject { instance.reference_set_filename }
      it { is_expected.to eq('.switch_db.yml') }
    end

    describe '#cache_dir' do
      subject { instance.cache_dir }
      it { is_expected.to eq(Pathname.new(File.expand_path('~/.cache/switch_db'))) }
    end
  end
end
