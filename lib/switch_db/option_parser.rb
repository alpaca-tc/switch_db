require 'optparse'

module SwitchDb
  class OptionParser
    def initialize(argv)
      @argv = argv.clone
      @args = {}
    end

    def parse!
      option_parser.parse!(@argv)
      @args[:command] = @argv.pop
      @args
    end

    private

    def option_parser
      ::OptionParser.new do |parser|
        parser.banner = <<~BANNER
          SwitchDb v#{SwitchDb::VERSION}
        BANNER

        parser.on('--name NAME', 'name') do |name|
          @args[:name] = name
        end

        parser.on('--database_names DATABASE_NAMES', 'database names') do |database_names|
          @args[:database_names] = database_names.split(/(?:,|\s+)/)
        end
      end
    end
  end
end


