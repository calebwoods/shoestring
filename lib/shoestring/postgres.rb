module Shoestring
  class Postgres < Base
    attr_reader :postgres_interactive

    def initialize(postgres_interactive = 'psql')
      @postgres_interactive = postgres_interactive
    end

    def check
      Shoestring::Generic.check('Postgres', install_help) do
        if system("which #{postgres_interactive} >/dev/null")
          true
        else
          puts "Postgres interactive command (#{postgres_interactive}) not found."
          false
        end
      end
    end

    private

    def install_help
      "You need to set up postgres.\nFor development it's recommended to use Postgres.app http://postgresapp.com/"
    end

  end
end
