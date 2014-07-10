require 'timedog/utils'

module Timedog
  module Status
    def self.run!
      output = `du -hcs #{Timedog::Utils.backup_root}`
      total_size = output.split("\n").last.split("\t").first
      puts "Your timedog backups are using #{total_size} of disk space"
      puts "Run `timedog clean` to remove these backups"
    end
  end
end
