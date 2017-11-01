RSpec.describe SwitchDb::Command::List do
  let(:instance) { described_class.new(reference_set: reference_set) }
  let(:reference_set) { SwitchDb::ReferenceSet.new(tmp_dir.join('reference.yml')) }

  describe '#run' do
    subject do
      -> { instance.run }
    end

    context 'when reference is empty' do
      it { is_expected.to output('').to_stdout }
    end

    context 'when reference is present' do
      before do
        reference_set.add_reference(reference)
      end

      let(:reference) { SwitchDb::Reference.new(name: 'name') }

      it { is_expected.to output("0: #{reference.name}\n").to_stdout }
    end
  end
end
