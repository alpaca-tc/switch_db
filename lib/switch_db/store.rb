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
        full_path = reference.database_path(database_name)
        next if File.exist?(full_path) && !overwrite?

        `mysqldump -u root -p #{database_name} > #{full_path}`
      end
    end

    private

    def overwrite?
      Dialog.question?("Overwrite existing file? #{reference.name}")
    end
  end
end
