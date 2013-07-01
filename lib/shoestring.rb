require "shoestring/version"

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

  class Homebrew
    attr_reader :name, :url, :brew_cmd, :block

    def self.check(*args, &block)
      self.new(*args, &block).check
    end

    def initialize(name, url, brew_cmd, &block)
      @name = name
      @url = url
      @brew_cmd = brew_cmd
      @block = block
    end

    def check
      if block.call
        puts "#{name}: check!"
      else
        puts "You need to setup #{name} #{url}"

        homebrew_installed = %x(brew -v)
        if homebrew_installed
          install_with_homebrew
        else
          install_homebrew
          install_with_homebrew
        end
      end
    end

    private
    def install_homebrew
      puts "Homebrew is not installed. Automatically install (y/n)"
      if STDIN.gets.strip == 'y'
        system('ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"') || abort("Could not install homebrew'. Please try manually http://mxcl.github.io/homebrew/")
      else
        abort_message
      end
    end

    def install_with_homebrew
      puts "Automatically install using homebrew (y/n)"
      if STDIN.gets.strip == 'y'
        system("brew install #{brew_cmd}") || abort("Could not run 'brew install #{brew_cmd}'. Please try manually")
      else
        abort_message
      end
    end

    def abort_message
      abort "Install #{name} and rerun"
    end
  end
end
