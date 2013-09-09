module Shoestring
  class Pow < Base
    attr_reader :host_name

    def initialize(host_name = `basename $PWD`)
      @host_name = host_name
    end

    def check
      install_pow
      system("powder link #{host_name}")
    end

    private

    def install_pow
      unless system("ps x | grep '[p]ow' > /dev/null")
        puts "Installing pow..."
        system("powder install")
      end
    end

  end
end
