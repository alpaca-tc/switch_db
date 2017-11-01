module SwitchDb
  module Command
    class Restore < Base
      attr_reader :reference

      def restore!(reference)
        reference.database_names.each do |database_name|
          `mysql -u root -p --execute="DROP DATABASE #{database_name}"`
          `mysql -u root -p --execute="CREATE DATABASE #{database_name}"`
          `mysql -u root -p #{database_name} < #{reference.database_path(database_name)}`
        end
      end
    end
  end
end
