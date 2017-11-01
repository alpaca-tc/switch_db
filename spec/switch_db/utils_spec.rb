RSpec.describe SwitchDb::Utils do
  describe 'ClassMethods' do
    describe '.escape_filename' do
      subject { described_class.escape_filename(value) }
      let(:value) { :value }
      it { is_expected.to eq(value.to_s) }
    end

    describe '.classify' do
      subject { described_class.classify(name) }

      context 'given `user_local`' do
        let(:name) { 'user_local' }
        it { is_expected.to eq('UserLocal') }
      end

      context 'given `USERLOCAL`' do
        let(:name) { 'USERLOCAL' }
        it { is_expected.to eq('Userlocal') }
      end
    end
  end
end
