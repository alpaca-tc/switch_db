require 'optparse'

module SwitchDb
  class OptionParser
    def initialize(argv)
      @original_argv = argv
      @argv = argv.clone
      @args = {}
    end

    def parse!
      option_parser.parse!(@argv)

      if @argv[0] == 'config'
        @args[:command] = 'config'
        parse_config_argv(@argv)
      else
        @args[:command] = @argv.shift if @argv[0]
        @args[:name] = @argv.shift if @argv[0]
      end

      @args
    end

    def option_parser
      ::OptionParser.new do |parser|
        parser.banner = banner

        parser.on('--database_names DATABASE_NAMES', 'database names') do |database_names|
          @args[:database_names] = database_names.split(/(?:,|\s+)/)
        end
      end
    end

    private

    def parse_config_argv(argv)
      key_values = argv.select { |key_value| key_value.include?(':') }

      key_values.each do |key_value|
        key, value = key_value.split(':')
        @args[key.to_sym] = value.to_s
      end
    end

    def banner
      <<~BANNER
        switch_db v#{SwitchDb::VERSION}

        switch_db is a database dupfile manager. This is a basic help message.
          Usage:
            switch_db list
            switch_db config [key:value...]
            switch_db rm <name>
            switch_db store <name> --database_names [database_names...]
            switch_db restore <name>

          Examples:
            switch_db rm feature1
            switch_db config user_name:root password:secret_password
            switch_db store feature1 --database_names db1,db2,db3
            switch_db restore feature1
      BANNER
    end
  end
end
