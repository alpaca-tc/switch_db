module SwitchDb
  module Database
    module Abstract
      def drop_database(_database_name)
        raise NotImplementedError
      end

      def create_database(_database_name)
        raise NotImplementedError
      end

      def import_database(_database_name, _database_path)
        raise NotImplementedError
      end

      def dump_database(_database_name, _output_path)
        raise NotImplementedError
      end
    end
  end
end
