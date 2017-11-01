module SwitchDb
  module Command
    class List < Base
      def run(*)
        puts 'none' if @reference_set.references.empty?

        @reference_set.references.each do |_, reference|
          puts "* #{reference.name}"
        end

        puts ''
      end
    end
  end
end
