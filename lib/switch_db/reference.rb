module SwitchDb
  class Reference
    attr_reader :name, :database_names, :metadata

    def initialize(name:, database_names: [], metadata: {})
      @name = name
      @database_names = database_names
      @metadata = metadata
    end

    def path
      Utils.escape_filename(@name)
    end

    def full_path
      SwitchDb.configuration.cache_dir.join(path)
    end

    def database_paths
      @database_names.map do |database_name|
        full_path.join("#{Utils.escape_filename(database_name)}.sql")
      end
    end
  end
end
