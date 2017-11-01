RSpec.describe SwitchDb::Command::Rm do
  let(:instance) { described_class.new(reference_set: reference_set) }
  let(:reference_set) { SwitchDb::ReferenceSet.new(tmp_dir.join('reference.yml')) }

  describe '#run' do
    subject do
      -> { instance.run(name: name) }
    end

    context "when reference doesn't exist" do
      let(:name) { 'unknown' }
      it { is_expected.to output('').to_stdout }
    end

    context 'when reference exist' do
      before do
        reference_set.add_reference(reference)
      end

      let(:name) { reference.name }
      let(:reference) { SwitchDb::Reference.new(name: 'name') }

      it { is_expected.to output("Deleted reference a (#{reference.name})\n").to_stdout }
      it { is_expected.to change(reference_set.references, :size).from(1).to(0) }
    end
  end
end
