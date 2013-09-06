module Shoestring
  class CopyConfigFile
    attr_reader :name, :source_file, :destination_file

    def self.check(*args)
      self.new(*args).check
    end

    def initialize(name, source_file, destination_file)
      @name = name
      @source_file = source_file
      @destination_file = destination_file
    end

    def check
      unless File.exists?(destination_file)
        FileUtils.cp source_file, destination_file
      end
      puts "#{name}: check!"
    end
  end

end
