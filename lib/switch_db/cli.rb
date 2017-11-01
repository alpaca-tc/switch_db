module SwitchDb
  class Cli
    class << self
      def run!(command, arguments = {})
        command_class = command_for(command)
        reference_set = ReferenceSet.load_file(SwitchDb.configuration.reference_set_file_full_path)
        command_class.new(reference_set: reference_set).run(arguments)
        reference_set.write_reference_set
      end

      private

      def command_for(command)
        Command.const_get(Utils.classify(command.to_s))
      rescue NameError
        raise CommandNotFound, "#{command} is unknown command."
      end
    end
  end
end
