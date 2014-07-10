require 'timedog/utils'

module Timedog
  module List
    def self.run!
      dirs = Timedog::Utils.backup_dirs
      puts "Run `timedog restore <number>` to restore your working directory to a backup."
      pretty_names = dirs.map {|d| d.split('/').last.to_i}.sort_by{}.reverse!
      pretty_names.each_with_index do |name, i|
        puts "[#{i+1}] #{name} created at #{Time.at(name)}"
      end
    end
  end
end
