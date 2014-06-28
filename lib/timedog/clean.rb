require 'fileutils'
require 'timedog/utils'

module Timedog
  module Clean
    def self.run!
      puts "Delete everything in .timedog/objects? [y/n]"
      if gets.chomp == 'y'
        puts "Removing everything in #{Timedog::Utils.backup_root}..."
        Dir["#{Timedog::Utils.backup_root}/*"].each do |dir|
          FileUtils.rm_rf(dir)
        end
        puts 'Done.'
      else
      end
    end
  end
end
