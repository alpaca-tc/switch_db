module SwitchDb
  module Database
    module Mysql
      extend Abstract

      def self.drop_database(database_name)
        `mysql -u #{SwitchDb.configuration.user_name} -p --execute="DROP DATABASE #{database_name}"`
      end

      def self.create_database(database_name)
        `mysql -u #{SwitchDb.configuration.user_name} -p --execute="CREATE DATABASE #{database_name}"`
      end

      def self.import_database(database_name, database_path)
        `mysql -u #{SwitchDb.configuration.user_name} -p #{database_name} < #{database_path}`
      end

      def self.dump_database(database_name, output_path)
        `mysqldump -u #{SwitchDb.configuration.user_name} -p #{database_name} > #{output_path}`
      end
    end
  end
end
