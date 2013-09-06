module Shoestring
  class Bundler < Base

    def check
      install_bundler
      install_gems
    end

    private

    def install_bundler
      Shoestring::Generic.check('Bundler') do
        unless system('bundle --version 2>&1')
          puts "Unable to find bundler.  Installing..."
          system('gem install bundler')
        end
        true
      end
    end

    def install_gems
      Shoestring::Cache.check(:bundle) do |old_version|
        version = File.read('Gemfile') + File.read('Gemfile.lock')
        if old_version != version
          system('bundle install --quiet') || abort('Failed to bundle install')
        end
        version
      end
      puts "Bundle Install: check!"
    end

  end
end
