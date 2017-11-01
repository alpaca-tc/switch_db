RSpec.describe SwitchDb::Command::Restore do
  let(:instance) { described_class.new(reference_set: reference_set) }
  let(:reference_set) { SwitchDb::ReferenceSet.new(tmp_dir.join('reference.yml')) }

  describe '#run' do
    subject do
      -> { instance.run(name: name) }
    end

    context 'when reference is empty' do
      let(:name) { 'name' }
      it { is_expected.to output('').to_stdout }
    end

    context 'when reference is present' do
      before do
        reference_set.add_reference(reference)
      end

      let(:name) { reference.name }
      let(:reference) { SwitchDb::Reference.new(name: 'name', database_names: ['db1']) }

      it 'calls database methods' do
        database = SwitchDb::Database.current_database

        expect(database).to receive(:drop_database)
        expect(database).to receive(:create_database)
        expect(database).to receive(:import_database)

        is_expected.to output("Restored database a 'db1'\n").to_stdout
      end
    end
  end
end
