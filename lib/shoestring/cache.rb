module Shoestring
  class Cache
    attr_reader :key, :block

    def self.check(*args, &block)
      self.new(*args, &block).check
    end

    def initialize(key, &block)
      @key = key
      @block = block
    end

    def check
      version = block.call(old_version)
      File.open(cache_file, 'w') { |f| f.puts(version || 'cached') }
    end

    private
    def cache_file
      "tmp/.#{key}"
    end

    def old_version
      File.exists?(cache_file) ? File.read(cache_file) : nil
    end
  end
end
