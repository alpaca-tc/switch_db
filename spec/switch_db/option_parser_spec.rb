RSpec.describe SwitchDb::OptionParser do
  describe 'InstanceMethods' do
    describe '#parse!' do
      subject { instance.parse! }
      let(:instance) { described_class.new(argv) }

      shared_examples_for 'a option parser' do |from, to|
        let(:argv) { from }
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

      it_behaves_like 'a option parser',
        %w[config username:alpaca-tc password:],
        command: 'config',
        username: 'alpaca-tc',
        password: ''

      context 'invalid option' do
        before do
          allow(instance).to receive(:exit).and_return(nil)
        end

        context 'given --unknown' do
          let(:argv) { %w[store test --unknown option] }
          it { expect { subject }.to output(/switch_db: '--unknown' is unknown option./).to_stderr }
        end

        context 'given --database_names and ' do
          let(:argv) { %w[store test --database_names] }
          it { expect { subject }.to output(/'--database_names' option is empty./).to_stderr }
        end
      end
    end
  end
end
