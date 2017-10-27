module SwitchDb
  class Cli
    def initialize(command, args = {})
      @command = command
      @args = args
    end

    def run!
      case @command.to_sym
      when :list
        puts 'none' if reference_set.references.empty?

        reference_set.references.each do |reference|
          puts "* #{reference.name}"
        end

        puts ''
      when :store
        reference = Reference.new(name: @args[:name], database_names: @args[:database_names], metadata: { created_at: Time.now })
        reference_set.add_reference(reference)
        Store.new(reference).store!

        reference_set.write_reference_set!
        puts "Store #{@args[:database_names]} to #{@args[:name]}"
      when :restore
        reference = reference_set.find_by_name(@args[:name])
        Restore.new(reference).restore!
        puts "Restore #{reference.database_names} to #{reference.name}"
      else
        raise "Unknown command given #{@command} with #{@args}"
      end
    end

    private

    def reference_set
      path = SwitchDb.configuration.cache_dir.join(SwitchDb.configuration.reference_set_filename)
      @reference_set ||= ReferenceSet.parse_reference_set!(path)
    end
  end
end
