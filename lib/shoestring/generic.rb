module Shoestring
  class Generic < Base
    attr_reader :name, :message, :block

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
