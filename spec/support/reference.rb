require 'pathname'

Module.new do
  def root_dir
    Pathname.new(File.expand_path('../../..', __FILE__))
  end

  def tmp_dir
    root_dir.join('tmp')
  end

  def temporary_reference
    SwitchDb::Reference.new(name: 'temporary', database_names: 'database_name')
  end

  RSpec.configure do |config|
    config.include(self)
  end
end
