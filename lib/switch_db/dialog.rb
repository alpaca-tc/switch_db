module SwitchDb
  module Dialog
    def self.question?(message)
      loop do
        print(message + ' y/n ')
        answer = $stdin.gets.strip

        return true if /\A(?:y|yes)\z/i =~ answer
        return false if /\A(?:n|no)\z/i =~ answer
      end
    end
  end
end
