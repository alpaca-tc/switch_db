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

      @args[:command] = @argv[0] if @argv[0]
      @args[:name] = @argv[1] if @argv[1]
      @args
    end

    private

    def option_parser
      ::OptionParser.new do |parser|
        parser.banner = banner

        parser.on('--database_names DATABASE_NAMES', 'database names') do |database_names|
          @args[:database_names] = database_names.split(/(?:,|\s+)/)
        end
      end
    end

    def banner
      <<~BANNER

        switch_db v#{SwitchDb::VERSION}

        switch_db is a snapshot database manager. This is a basic help message.

          Usage:
            switch_db list
            switch_db rm <name>
            switch_db store <name> --database_names [database_names...]
            switch_db restore <name>

          Examples:
            switch_db rm feature1
            switch_db store feature1 --database_names db1,db2,db3
            switch_db restore feature1
      BANNER
    end
  end
end
