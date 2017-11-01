module SwitchDb
  class SwitchDbError < StandardError; end
  class CommandNotFound < SwitchDbError; end
end
