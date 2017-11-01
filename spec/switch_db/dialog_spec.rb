RSpec.describe SwitchDb::Dialog do
  describe 'ClassMethods' do
    describe '.question?' do
      subject { described_class.question?(message) }

      before do
        allow(described_class).to receive(:print).and_return(nil)
        allow($stdin).to receive(:gets).and_return(gets)
      end

      let(:message) { 'Continue?' }

      context 'user inputs `y`' do
        let(:gets) { 'y' }
        it { is_expected.to be true }
      end

      context 'user inputs `yes`' do
        let(:gets) { 'yes' }
        it { is_expected.to be true }
      end

      context 'user inputs `n`' do
        let(:gets) { 'n' }
        it { is_expected.to be false }
      end

      context 'user inputs `no`' do
        let(:gets) { 'no' }
        it { is_expected.to be false }
      end
    end
  end
end
