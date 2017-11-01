require 'pathname'

Module.new do
  def root_dir
    Pathname.new(File.expand_path('../../..', __FILE__))
  end

  def tmp_dir
    root_dir.join('tmp')
  end

  RSpec.configure do |config|
    config.include(self)

    config.before do
      allow_any_instance_of(SwitchDb::Configuration).to receive(:cache_dir).and_return(tmp_dir)
    end
  end
end
