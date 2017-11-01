module SwitchDb
  class SwitchDbError < StandardError; end
  class CommandNotFound < SwitchDbError; end
  class UnknownConfigurationKey < SwitchDbError; end
end
