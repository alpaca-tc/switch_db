module SwitchDb
  module Database
    require 'switch_db/database/abstract'
    require 'switch_db/database/mysql'

    # Currently, supported database is only 'mysql'
    def self.current_database
      SwitchDb::Database::Mysql
    end
  end
end
