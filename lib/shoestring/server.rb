module Shoestring
  class Server

    def self.start(command = 'bundle exec rails s')
      puts "\nShoestrings tied!\nStarting app server..."
      system %(#{command})
    end

  end
end
