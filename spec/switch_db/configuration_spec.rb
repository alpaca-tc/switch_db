RSpec.describe SwitchDb::Configuration do
  describe 'InstanceMethods' do
    let(:instance) { described_class.new }

    describe '#reference_set_file' do
      subject { instance.reference_set_file }
      it { is_expected.to eq('reference_set.yml') }
    end

    describe '#user_name' do
      subject { instance.user_name }
      it { is_expected.to eq('root') }
    end

    describe '#cache_dir' do
      subject { instance.cache_dir }
      it { is_expected.to eq(tmp_dir) }
    end
  end
end
