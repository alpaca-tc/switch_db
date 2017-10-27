require 'fileutils'

module SwitchDb
  class Store
    attr_reader :reference

    def initialize(reference)
      @reference = reference
    end

    def store!
      FileUtils.mkdir_p(reference.full_path)

      reference.database_names.each do |database_name|
        `mysqldump -u root -p #{database_name} > #{reference.database_path(database_name)}`
      end
    end
  end
end
