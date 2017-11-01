require 'fileutils'

module SwitchDb
  module Command
    class Store < Base
      def run(name:, database_names: [])
        reference = SwitchDb::Reference.new(name: name, database_names: database_names)
        duplicated = @reference_set.references.key?(reference.name)

        FileUtils.mkdir_p(reference.full_path)

        reference.database_paths.each do |database_name, database_path|
          next if duplicated && !overwrite?(reference)

          SwitchDb::Database.current_database.dump_database(database_name, database_path)
          puts "Stored database a '#{database_name}'"
        end

        @reference_set.add_reference(reference)
      end

      private

      def overwrite?(reference)
        Dialog.question?("Overwrite existing stored file? (#{reference.name})")
      end
    end
  end
end
