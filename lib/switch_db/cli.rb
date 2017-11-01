module SwitchDb
  class Cli
    class << self
      def run!(command, arguments = {})
        command_class = command_for(command)

        path = SwitchDb.configuration.cache_dir.join(SwitchDb.configuration.reference_set_filename)
        reference_set = ReferenceSet.load_file(path)

        command_class.new(reference_set: reference_set).run(arguments)

        # case @command.to_sym
        # when :list
        # when :rm
        #   reference = find_by_name(@args[:name])
        #   Rm.new(reference).rm!
        #   reference_set.remove_reference(reference)
        #   reference_set.write_reference_set!
        #
        #   puts "Remove #{reference.name}"
        # when :store
        #   reference = Reference.new(name: @args[:name], database_names: @args[:database_names], metadata: { created_at: Time.now })
        #   reference_set.add_reference(reference)
        #   Store.new(reference).store!
        #
        #   reference_set.write_reference_set!
        #   puts "Store #{@args[:database_names]} to #{@args[:name]}"
        # when :restore
        #   reference = find_by_name(@args[:name])
        #   Restore.new(reference).restore!
        #   puts "Restore #{reference.database_names} to #{reference.name}"
        # else
        #   raise "Unknown command given #{@command} with #{@args}"
        # end
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
