module Shoestring
  class Pow < Base
    attr_reader :host_name

    def initialize(host_name = `basename $PWD`)
      @host_name = host_name
    end

    def check
      system("powder link #{host_name}")
    end

  end
end
