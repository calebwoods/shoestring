module Shoestring
  class PowDns < Base
    attr_reader :port

    def initialize(port = 3000)
      @port = port
    end

    def check
      Shoestring::Generic.check('Pow DNS') do
        # config port for forman if installed
        %x(if [ -f Procfile ]; then echo "port: #{port}" > .foreman; fi)

        # Set up DNS through Pow
        %x(if [ -d ~/.pow ]
        then
          echo #{port} > ~/.pow/`basename $PWD`
        else
          echo "Pow is not set up but the team uses it for this project. Setup: http://goo.gl/RaDPO"
        fi)
      end
    end

  end
end
