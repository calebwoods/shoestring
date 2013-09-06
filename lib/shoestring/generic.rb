module Shoestring
  class Generic
    attr_reader :name, :message, :block

    def self.check(*args, &block)
      self.new(*args, &block).check
    end

    def initialize(name, message="Unable to check #{name}", &block)
      @name = name
      @message = message
      @block = block
    end

    def check
      block.call || abort(message)
      puts "#{name}: check!"
    end
  end
end
