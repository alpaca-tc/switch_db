RSpec.describe SwitchDb::Utils do
  describe 'ClassMethods' do
    describe '.escape_filename' do
      subject { described_class.escape_filename(value) }
      let(:value) { :value }
      it { is_expected.to eq(value.to_s) }
    end
  end
end
