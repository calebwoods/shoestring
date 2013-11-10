module Shoestring
  class Cache < Base
    attr_reader :key, :block

    def initialize(key, &block)
      @key = key
      @block = block
    end

    def check
      version = block.call(old_version)
      write_version(version)
    end

    private
    def write_version(version)
      FileUtils.mkdir_p(cache_directory)
      File.open(cache_file, 'w') { |f| f.puts(version || 'cached') }
    end

    def cache_file
      "#{cache_directory}/.#{key}"
    end

    def cache_directory
      'tmp'
    end

    def old_version
      File.exists?(cache_file) ? File.read(cache_file) : nil
    end

  end
end
