RSpec.describe SwitchDb::OptionParser do
  describe 'InstanceMethods' do
    describe '#parse!' do
      shared_examples_for 'a option parser' do |from, to|
        subject { instance.parse! }
        let(:instance) { described_class.new(from) }
        it { is_expected.to eq(to) }
      end

      it_behaves_like 'a option parser',
        %w[store test --database_names db1,db2],
        command: 'store',
        name: 'test',
        database_names: %w[db1 db2]

      it_behaves_like 'a option parser',
        %w[restore test],
        command: 'restore',
        name: 'test'

      it_behaves_like 'a option parser',
        %w[list],
        command: 'list'
    end
  end
end
