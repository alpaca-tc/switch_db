RSpec.describe SwitchDb::Command::Store do
  let(:instance) { described_class.new(reference_set: reference_set) }
  let(:reference_set) { SwitchDb::ReferenceSet.new(tmp_dir.join('reference.yml')) }

  describe '#run' do
    subject do
      -> { instance.run(name: 'name', database_names: ['db1']) }
    end

    context "when reference doesn't exist" do
      it 'dumps database' do
        database = SwitchDb::Database.current_database
        expect(database).to receive(:dump_database)

        is_expected.to output("Stored database a 'db1'\n").to_stdout
      end
    end

    context 'when reference exist' do
      before do
        reference_set.add_reference(reference)
      end

      let(:reference) { SwitchDb::Reference.new(name: 'name') }

      it 'calls #overwrite?' do
        expect(instance).to receive(:overwrite?)
        subject.call
      end
    end
  end
end
