require 'yaml'
require 'erb'

module Shoestring
  class Migration < Base

    def check
      Shoestring::Generic.check('Database Migrations') do
        status = db_status
        if $?.success?
          check_schema
          true
        else
          setup_database(status)
        end
      end
    end

    private

    def check_schema
      Shoestring::Cache.check(:schema) do |old_version|
        if File.exist?("db/schema.rb")
          version = File.readlines("db/schema.rb").find { |line| line.include?("define(:version") }
        else
          version = File.readlines("db/structure.sql").last
        end
        if old_version.to_s.strip != version.to_s.strip
          system("bundle exec rake db:migrate") || abort("bundle exec rake db:migrate failed")
        end
        version
      end
    end

    def setup_database(status)
      if status =~ /role.* does not exist/
        abort "Trouble connecting to database using the user #{db_config['username']}."
      elsif status =~ /database.* does not exist/
        puts "Unable to find the database #{db_config['database']}. Creating it now..."
        system("bundle exec rake db:setup") || abort("bundle exec rake db:setup failed")
      elsif status =~ /relation \"schema_migrations\" does not exist/
        puts "No migrations table. Creating it now..."
        system("bundle exec rake db:setup") || abort("bundle exec rake db:setup failed")
      else
        abort "Error determining the migration status: #{status}"
      end
    end

    def db_config
      @db_config ||= YAML.load(ERB.new(IO.read('./config/database.yml')).result)['development']
    end

    def db_status
      if db_config['adapter'] == 'postgresql'
        ENV['PGPASSWORD'] = db_config['password']
        %x(psql -d #{db_config['database']} -U #{db_config['username']} -c "SELECT * from schema_migrations" 2>&1)
      else
        abort("#{db_config['adapter']} is not a support adapter")
      end
    end

  end
end
