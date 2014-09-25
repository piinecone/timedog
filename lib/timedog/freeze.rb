require 'timedog/utils'

module Timedog
  module Freeze
    def self.run!
      restore_points = ARGV
      restore_points.each do |restore_point|
        restore_dir = Timedog::Utils.backup_dir_at_index restore_point.to_i
        puts restore_dir
        freeze_dir = restore_dir.gsub(Timedog::Utils.backup_root, Timedog::Utils.freeze_root)
        puts freeze_dir
        puts "filepaths for #{restore_dir}: #{get_filepaths(restore_dir)}"
        get_filepaths(restore_dir).each do |filepath|
          src = filepath
          dst = filepath.gsub(restore_dir, freeze_dir)
          puts "copying #{src} to #{dst}"
          FileUtils.mkdir_p(File.dirname(dst))
          FileUtils.cp(src, dst)
        end
      end
    end

    private

    def self.get_filepaths(prefix='.')
      Timedog::Utils.get_filepaths(prefix)
    end
  end
end
