module Shoestring
  class Homebrew < Base
    attr_reader :name, :url, :brew_cmd, :block

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

        if system('brew -v')
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
