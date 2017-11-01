module SwitchDb
  module Command
    class Rm
      attr_reader :reference

      def initialize(reference)
        @reference = reference
      end

      def rm!
        FileUtils.rm_rf(reference.full_path)
      end
    end
  end
end
