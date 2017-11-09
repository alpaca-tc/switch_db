require 'optparse'

module SwitchDb
  class OptionParser
    REQUIRED_KEYS = {
      store: %i[name --database_names],
      restore: [:name],
      rm: [:name],
      list: []
    }.freeze

    def initialize(argv)
      @original_argv = argv
      @options = {}
    end

    def parse!(argv = @original_argv.clone)
      @options[:command] = argv[0]

      # rubocop:disable Lint/EmptyWhen
      case @options[:command]
      when 'list'
        # Do nothing
      when 'config'
        parse_config_argv(argv[1..-1])
      when 'store', 'restore', 'rm'
        @options[:name] = argv[1]
        parse_argv(argv)
      else
        parse_argv(argv)
      end
      # rubocop:enable Lint/EmptyWhen

      validate_option!

      @options
    end

    private

    def validate_option!
      required_keys = REQUIRED_KEYS[@options[:command].to_s.to_sym]

      if required_keys.nil?
        print_error("'#{@options[:command]}' is unknown command.")
      elsif required_keys.include?(:name) && @options[:name].to_s.empty?
        print_error("<name> is empty.")
      else
        required_keys.select { |name| name.to_s.start_with?('--') }.each do |name|
          name = name.to_s.gsub(/^--/, '').to_sym
          value = @options[name]
          print_error("'--#{name}' option is empty.") if value.nil? || value.empty?
        end
      end
    end

    def parse_config_argv(argv)
      key_values = argv.select { |key_value| key_value.include?(':') }

      key_values.each do |key_value|
        key, value = key_value.split(':')
        @options[key.to_sym] = value.to_s
      end
    end

    def parse_argv(argv)
      argv.each_with_index do |raw_key, index|
        next unless raw_key.start_with?('--')

        key = raw_key.gsub(/^--/, '')
        next_index = index + 1
        value = argv[next_index] unless argv[next_index].to_s.start_with?('--')
        parse_option(key, value)
      end
    end

    def parse_option(option_name, value)
      case option_name
      when 'database_names'
        @options[:database_names] = value.to_s.split(/(?:,|\s+)/)
      when 'help'
        puts banner
        exit
      else
        print_error("'--#{option_name}' is unknown option.")
      end
    end

    def print_error(message)
      $stderr.puts("switch_db: #{message} See 'switch_db --help'")
      exit
    end

    def banner
      <<~BANNER
        switch_db v#{SwitchDb::VERSION}

        switch_db is a database dumpfile manager. This is a basic help message.
          Usage:
            switch_db list
            switch_db config [key:value...]
            switch_db rm <name>
            switch_db store <name> --database_names [database_name,database_name...]
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
