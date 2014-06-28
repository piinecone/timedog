require 'pry-nav'
require 'listen'
require 'timedog/utils'

module Timedog
  module Watch
    def self.run!
      create_initial_backup
      loop do
        should_create_backup = false
        changed_files = []
        unchanged_files = []

        self.filepaths.each do |filepath|
          if Timedog::Utils.files_exactly_match?(filepath, most_recent_backup_of(filepath))
            unchanged_files << filepath
          else
            changed_files << filepath
            should_create_backup = true
          end
        end

        if should_create_backup
          puts "#{changed_files.count} file(s) changed, creating recovery point..."
          backup_dir = create_backup_dir
          unchanged_files.each do |unchanged_file|
            last_backup = most_recent_backup_of(unchanged_file, before: backup_dir)
            target_backup_path = "#{backup_dir}/#{unchanged_file}"
            # puts "Symlinking #{target_backup_path} to #{last_backup}"
            FileUtils.mkdir_p(File.dirname(target_backup_path))
            File.symlink(File.expand_path(last_backup), target_backup_path)
          end
          changed_files.each do |changed_file|
            target_backup_path = "#{backup_dir}/#{changed_file}"
            # puts "Copying #{changed_file} to #{target_backup_path}"
            copy_src_to_dst changed_file, target_backup_path
          end
          puts "[#{Time.now}] Created recovery point at #{backup_dir}"
        end

        unchanged_files = []
        changed_files = []
        should_create_backup = false

        sleep 120
      end
    end

    private

    def self.most_recent_backup_of(filepath, options={})
      path = recent_backup_path_for(filepath, options)
      if File.symlink? path
        File.readlink path
      else
        path
      end
    end

    def self.create_backup_dir
      Timedog::Utils.backup_dir
    end

    def self.create_initial_backup
      if Timedog::Utils.backup_dirs.empty?
        puts 'Creating initial backup...'
        backup_dir = Timedog::Utils.backup_dir
        self.filepaths.each do |filepath|
          backup_filepath = "#{backup_dir}/#{filepath}"
          copy_src_to_dst(filepath, backup_filepath)
        end
        puts 'Done.'
      else
        puts 'Using existing backup directories. Run `timedog clean` to remove these.'
      end
    end

    def self.copy_src_to_dst(src, dst)
      FileUtils.mkdir_p(File.dirname(dst))
      FileUtils.cp(src, dst)
    end

    def self.recent_backup_path_for(filename, options={})
      "#{Timedog::Utils.recent_backup_dir(options)}/#{filename}"
    end

    def self.filepaths
      @filepaths ||= begin
        paths = []
        patterns.each do |pattern|
          extension = pattern.partition('.').last
          match = "**/*.#{extension}"
          paths << Dir[match]
        end
        paths.flatten
      end
    end

    def self.patterns
      @patterns ||= begin 
        patterns = []
        File.open(Timedog::Utils.config_filename, 'r') do |file|
          file.each_line do |line|
            line.gsub!('\n', '')
            line.gsub!('\t', '')
            line.gsub!('\r', '')
            line.gsub!(/\s+/, '')
            patterns << line
          end
        end
        patterns
      end
    end
  end
end
