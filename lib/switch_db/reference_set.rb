require 'fileutils'
require 'yaml'

module SwitchDb
  class ReferenceSet
    attr_reader :references

    def initialize(path, references = [])
      @path = path
      @references = references
    end

    def self.parse_reference_set!(path)
      yaml = YAML.load_file(path)

      references = (yaml[:references] || []).map do |reference|
        Reference.new(name: reference[:name], database_names: reference[:database_names], metadata: reference[:metadata])
      end

      new(path, references)
    rescue Errno::ENOENT
      puts "No such file or directory - #{path}"
      new(path)
    end

    def add_reference(reference)
      @references.push(reference)
    end

    def remove_reference(reference)
      @references.delete(reference)
    end

    def find_by_name(name)
      @references.find { |reference| reference.name == name }
    end

    def write_reference_set!
      FileUtils.mkdir_p(File.dirname(@path))

      content = {}

      content[:references] = references.map do |reference|
        {
          name: reference.name,
          database_names: reference.database_names,
          metadata: reference.metadata
        }
      end

      File.write(@path, content.to_yaml)
    end
  end
end
