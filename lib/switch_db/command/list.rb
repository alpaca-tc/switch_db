module SwitchDb
  module Command
    class List < Base
      def run(*)
        length = @reference_set.references.size.to_s.length

        @reference_set.references.each_with_index do |(_, reference), index|
          puts "#{format_index(length, index)}: #{reference.name}"
        end
      end

      private

      def format_index(length, index)
        format("%#{length}d", index)
      end
    end
  end
end
