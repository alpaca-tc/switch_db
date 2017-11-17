require 'pathname'
require 'fileutils'

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
      @password = nil

      load_from_config_file(configuration_full_path)
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

    def write_configuration_file
      FileUtils.mkdir_p(File.dirname(configuration_full_path))
      File.write(configuration_full_path, to_h.to_yaml)
    end

    def configuration_keys
      %i[
        reference_set_file
        user_name
        password
      ]
    end

    private

    def configuration_full_path
      cache_dir.join(config_file)
    end

    def load_from_config_file(path)
      yaml = YAML.load_file(path)

      yaml.each do |key, value|
        case key
        when 'cache_dir'
          @cache_dir = Pathname.new(File.expand_path(cache_dir))
        else
          public_send("#{key}=", value) if respond_to?("#{key}=")
        end
      end
    rescue Errno::ENOENT
      # Do nothing
    end
  end
end
