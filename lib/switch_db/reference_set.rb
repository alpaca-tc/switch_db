require 'fileutils'
require 'yaml'

module SwitchDb
  class ReferenceSet
    attr_reader :configuration_path, :references

    def initialize(configuration_path)
      @configuration_path = configuration_path
      @references = {}
    end

    def self.load_file(configuration_path)
      new(configuration_path).tap do |instance|
        yaml = YAML.load_file(configuration_path)

        (yaml[:references] || []).map do |reference|
          reference = Reference.new(
            name: reference[:name],
            database_names: reference[:database_names]
          )

          instance.add_reference(reference)
        end
      end
    rescue Errno::ENOENT
      new(configuration_path)
    end

    def add_reference(reference)
      @references[reference.name] = reference
    end

    def remove_reference(reference)
      @references.delete(reference.name)
    end

    def write_reference_set
      FileUtils.mkdir_p(configuration_directory)
      File.write(@configuration_path, to_h.to_yaml)
    end

    private

    def to_h
      {
        references: references.values.map(&:to_h)
      }
    end

    def configuration_directory
      File.dirname(@configuration_path)
    end
  end
end
