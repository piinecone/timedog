require 'timedog/color'

module Timedog
  def self.project_root
    File.basename(Dir.getwd).downcase
  end

  module Application
    def self.run!
      cmd = ARGV.shift

      case cmd
        when 'add'
          require 'timedog/add'
          Timedog::Add.run!
        when 'remove'
          require 'timedog/remove'
          Timedog::Add.run!
        when 'watch'
          require 'timedog/watch'
          Timedog::Watch.run!
        when 'restore'
          require 'timedog/fetch'
          Timedog::Fetch.run! # steps or time
        when 'clean'
          require 'timedog/clean'
          Timedog::Clean.run!
        when 'status'
          require 'timedog/status'
          Timedog::Status.run!
        when 'list'
          require 'timedog/list'
          Timedog::List.run!
        else
          print <<EOF
usage: timedog list|watch|restore|add|remove|clean

   status
   list
   watch
   restore
   add
   remove
   clean

EOF
      end
    end
  end
end
