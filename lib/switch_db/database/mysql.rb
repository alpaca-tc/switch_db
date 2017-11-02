module SwitchDb
  module Database
    module Mysql
      extend Abstract

      class << self
        def drop_database(database_name)
          `mysql #{user_and_password} --execute="DROP DATABASE #{database_name}"`
        end

        def create_database(database_name)
          `mysql #{user_and_password} --execute="CREATE DATABASE #{database_name}"`
        end

        def import_database(database_name, database_path)
          `mysql #{user_and_password} #{database_name} < #{database_path}`
        end

        def dump_database(database_name, output_path)
          `mysqldump #{user_and_password} #{database_name} > #{output_path}`
        end

        private

        def user_and_password
          arguments = ["-u #{SwitchDb.configuration.user_name}"]
          arguments.push("-p#{SwitchDb.configuration.password}") if SwitchDb.configuration.password

          arguments.join(' ')
        end
      end
    end
  end
end
