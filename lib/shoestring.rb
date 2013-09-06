require "shoestring/version"

module Shoestring
  class Base

    def self.check(*args, &block)
      self.new(*args, &block).check
    end

  end
end

require "shoestring/bundler"
require "shoestring/cache"
require "shoestring/copy_config_file"
require "shoestring/generic"
require "shoestring/homebrew"
require "shoestring/migration"
require "shoestring/postgres"
require "shoestring/pow_dns"
