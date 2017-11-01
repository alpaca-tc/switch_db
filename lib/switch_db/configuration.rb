require 'pathname'

module SwitchDb
  class Configuration
    attr_reader :config_file
    attr_reader :cache_dir
    attr_accessor :reference_set_file
    attr_accessor :user_name
    attr_accessor :password

    def initialize
      @config_file = 'config.yml'
      @reference_set_file = 'reference_set.yml'
      @cache_dir = Pathname.new(File.expand_path('~/.cache/switch_db'))
      @user_name = 'root'
      @password = ''

      load_from_config_file(cache_dir.join(reference_set_file))
    end

    def reference_set_file_full_path
      cache_dir.join(reference_set_file)
    end

    def to_h
      {
        reference_set_file: reference_set_file,
        user_name: user_name,
        password: password
      }
    end

    private

    def load_from_config_file(path)
      yaml = YAML.load_file(path)

      yaml.each do |key, value|
        case key
        when 'cache_dir'
          @cache_dir = Pathname.new(File.expand_path(cache_dir))
        else
          public_send("#{key}=", value)
        end
      end
    rescue Errno::ENOENT
      # Do nothing
    end
  end
end
