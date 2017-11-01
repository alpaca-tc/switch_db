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

  def self.run(argv)
    args = OptionParser.new(argv).parse!
    command = args.delete(:command)

    Cli.run!(command, args)
  end
end
