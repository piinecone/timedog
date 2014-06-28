require 'timedog/utils'

module Timedog
  module Fetch
    def self.run!
      index = ARGV
      restore_dir = Timedog::Utils.backup_dir_at_index index.first.to_i
      get_filepaths(restore_dir).each do |filepath|
        src = filepath
        dst = filepath.gsub(restore_dir, '.')
        puts "copying #{src} to #{dst}"
        FileUtils.mkdir_p(File.dirname(dst))
        FileUtils.cp(src, dst)
      end
    end

    private

    # FIXME move these to utils
    def self.get_filepaths(prefix='.')
      @filepaths ||= begin
        paths = []
        patterns.each do |pattern|
          extension = pattern.partition('.').last
          match = "#{prefix}/**/*.#{extension}"
          puts match
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
