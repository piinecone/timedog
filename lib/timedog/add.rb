require 'fileutils'
require 'timedog/utils'

module Timedog
  module Add
    def self.run!
      patterns = ARGV
      add_patterns_to_watchlist patterns
    end

    private

    def self.add_patterns_to_watchlist(pattern_strings)
      filename = Timedog::Utils.config_filename
      pattern_strings.each do |string|
        pattern = "*#{string.match(/\..+/)[0]}"
        if file_contains_line?(filename, pattern)
          puts "#{pattern} is already present in #{filename}"
        else
          File.open(filename, 'a') do |file|
            file.puts pattern
          end
          puts "Added #{pattern} to #{filename}"
        end
      end
    end

    def self.file_contains_line?(filename, match)
      File.open(filename).each do |line|
        return true if line.chomp == match
      end
      false
    end
  end
end
