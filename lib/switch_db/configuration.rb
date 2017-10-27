require 'pathname'

module SwitchDb
  class Configuration
    def reference_set_filename
      '.switch_db.yml'
    end

    def cache_dir
      Pathname.new(File.expand_path('~/.cache/switch_db'))
    end
  end
end
