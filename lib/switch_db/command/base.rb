module SwitchDb
  module Command
    class Base
      def initialize(reference_set:)
        @reference_set = reference_set
      end

      def run(_arguments = {})
        raise NotImplementedError, 'not implemented yet'
      end
    end
  end
end
