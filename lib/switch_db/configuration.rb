require 'pathname'

module SwitchDb
  class Configuration
    attr_accessor :reference_set_filename
    attr_accessor :cache_dir
    attr_accessor :user_name
    attr_accessor :password

    def initialize
      @reference_set_filename = '.switch_db.yml'
      @cache_dir = Pathname.new(File.expand_path('~/.cache/switch_db'))
      @user_name = 'root'
      @password = ''
    end
  end
end
