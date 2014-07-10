require 'digest'
require 'fileutils'

module Timedog
  module Utils
    CONFIG_PATH = '.timedog/config'
    BACKUP_PATH = '.timedog/objects'

    def self.config_filename
      unless File.directory?('.timedog')
        Dir.mkdir '.timedog'
      end
      unless File.exists?(CONFIG_PATH)
        File.new(CONFIG_PATH, 'w')
      end

      CONFIG_PATH
    end

    def self.backup_dir
      path = "#{BACKUP_PATH}/#{Time.now.to_i}"
      FileUtils.mkdir_p(path)

      path
    end

    def self.backup_dirs
      Dir["#{Timedog::Utils.backup_root}/*"]
    end

    def self.backup_dir_at_index(index)
      backup_dirs.sort_by{}.reverse![index-1]
    end

    def self.backup_root
      FileUtils.mkdir_p(BACKUP_PATH)

      BACKUP_PATH
    end

    def self.recent_backup_dir(options={})
      dirs = backup_dirs
      dirs.delete options.fetch(:before, '')
      dirs.each {|d| d.split('/').last }.max
    end

    def self.files_exactly_match?(file_a, file_b)
      File.exists?(file_a) && File.exists?(file_b) &&
        cross_platform_hash(file_a) == cross_platform_hash(file_b)
    end

    private

    def self.cross_platform_hash(filename)
      Digest::MD5.hexdigest(File.open(filename, 'rb') {|f| f.read})
    end

    #def self.file_and_object_match?(filepath, object)
    #  # TODO fix this so it works identically on OS X and Windows
    #  object.exists? && object.etag.gsub(/"/, '') == Digest::MD5.hexdigest(File.open(filepath, 'rb') {|f| f.read})
    #  # object.exists? && object.content_length == File.stat(filepath).size
    #end
  end
end
