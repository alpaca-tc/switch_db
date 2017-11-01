require 'switch_db/cli'
require 'switch_db/exceptions'
require 'switch_db/configuration'
require 'switch_db/dialog'
require 'switch_db/option_parser'
require 'switch_db/reference'
require 'switch_db/reference_set'
require 'switch_db/utils'
require 'switch_db/version'
require 'switch_db/command'
require 'switch_db/database'

module SwitchDb
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configuration=(value)
    @configuration = value
  end

  def self.run(argv)
    option_parser = SwitchDb::OptionParser.new(argv)
    args = option_parser.parse!
    command = args.delete(:command)

    Cli.run!(command, args)
  rescue SwitchDb::CommandNotFound => error
    $stderr.puts(error.message)
    $stderr.puts(option_parser.option_parser.banner)
  end
end
