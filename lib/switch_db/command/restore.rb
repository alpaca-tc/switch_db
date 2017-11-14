module SwitchDb
  module Command
    class Restore < Base
      attr_reader :reference

      def run(name:, **)
        reference = @reference_set.references[name.to_s]

        unless reference
          $stderr.puts("#{name} not exists")
          exit
        end

        database = SwitchDb::Database.current_database

        reference.database_paths.each do |database_name, database_path|
          database.drop_database(database_name)
          database.create_database(database_name)
          database.import_database(database_name, database_path)

          puts "Restored database a '#{database_name}'"
        end
      end
    end
  end
end
