module SwitchDb
  class Reference
    attr_reader :name, :database_names

    def initialize(name:, database_names: [])
      @name = name
      @database_names = database_names
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

    def to_h
      {
        name: name,
        database_names: database_names
      }
    end
  end
end
