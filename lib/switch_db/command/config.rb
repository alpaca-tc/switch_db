require 'fileutils'

module SwitchDb
  module Command
    class Config < Base
      def run(arguments = {})
        arguments.each do |key, value|
          if SwitchDb.configuration.configuration_keys.include?(key.to_sym)
            SwitchDb.configuration.public_send("#{key}=", value)
          else
            raise SwitchDb::UnknownConfigurationKey, "Unknown configuration given (#{key})"
          end
        end

        SwitchDb.configuration.write_configuration_file
      end
    end
  end
end
