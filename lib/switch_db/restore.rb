module SwitchDb
  class Restore
    attr_reader :reference

    def initialize(reference)
      @reference = reference
    end

    def restore!
      reference.database_names.each do |database_name|
        `mysql -u root -p --execute="DROP DATABASE #{database_name}"`
        `mysql -u root -p --execute="CREATE DATABASE #{database_name}"`
        `mysql -u root -p #{database_name} < #{reference.database_path(database_name)}`
      end
    end
  end
end
