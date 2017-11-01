require 'fileutils'

module SwitchDb
  module Command
    class Rm < Base
      def run(name:, **)
        reference = @reference_set.references[name.to_s]
        return unless reference

        @reference_set.remove_reference(reference)
        puts "Deleted reference a (#{reference.name})"
        FileUtils.rm_rf(reference.full_path)
      end
    end
  end
end
