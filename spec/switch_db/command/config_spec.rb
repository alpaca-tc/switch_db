RSpec.describe SwitchDb::Command::Config do
  let(:instance) { described_class.new(reference_set: reference_set) }
  let(:reference_set) { SwitchDb::ReferenceSet.new(tmp_dir.join('reference.yml')) }

  describe '#run' do
    subject do
      -> { instance.run(key => 'username') }
    end

    context 'when configuration key exist' do
      let(:key) { :username }

      it 'updates configuration' do
      end
    end

    context "when configuration key doesn't exist" do
      let(:key) { :unknown }
      it { is_expected.to raise_error(SwitchDb::UnknownConfigurationKey) }
    end
  end
end
