module SwitchDb
  module Utils
    def self.escape_filename(name)
      name.to_s
    end

    def self.classify(name)
      name.split(/[\-_]/).map { |part|
        "#{part[0].upcase}#{part[1..-1].downcase}"
      }.join
    end
  end
end
