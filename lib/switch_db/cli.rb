module SwitchDb
  class Cli
    class << self
      def run!(command, arguments = {})
        command_class = command_for(command)

        path = SwitchDb.configuration.cache_dir.join(SwitchDb.configuration.reference_set_filename)
        reference_set = ReferenceSet.load_file(path)

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
