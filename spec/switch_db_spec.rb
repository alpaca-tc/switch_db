require "spec_helper"

RSpec.describe SwitchDb do
  describe 'ClassMethods' do
    describe '.configuration' do
      subject { described_class.configuration }
      it { is_expected.to be_a(described_class::Configuration) }
    end

    describe '.run' do
      subject do
        described_class.run(['list'])
      end

      it 'calls command' do
        expect_any_instance_of(described_class::Cli).to receive(:initialize).with('list', {})
        subject
      end
    end
  end
end
