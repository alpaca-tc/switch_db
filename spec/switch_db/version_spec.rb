RSpec.describe SwitchDb do
  describe 'VERSION' do
    subject { described_class::VERSION }
    it { is_expected.to match(/\d+\.\d+\.\d+/) }
  end
end
