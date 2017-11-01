module SwitchDb
  module Database
    module Abstract
      def drop_database(database_name)
        raise NotImplementedError
      end

      def create_database(database_name)
        raise NotImplementedError
      end

      def import_database(database_name, database_path)
        raise NotImplementedError
      end
    end
  end
end
