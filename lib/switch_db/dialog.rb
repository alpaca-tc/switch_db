module SwitchDb
  module Dialog
    def self.question?(message)
      loop do
        print(message + ' y/n ')
        answer = $stdin.gets.strip

        return true if /\A(?:y|yes)\z/i.match?(answer)
        return false if /\A(?:n|no)\z/i.match?(answer)
      end
    end
  end
end
