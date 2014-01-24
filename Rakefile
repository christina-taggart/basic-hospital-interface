require 'rake'
require 'rspec/core/rake_task'
require_relative 'lib/sunlight_legislators_importer'
require_relative 'lib/tweets_importer'
require_relative 'db/config'

desc "create the database"
task "db:create" do
  touch 'db/ar-sunlight-legislators.sqlite3'
end

desc "drop the database"
task "db:drop" do
  rm_f 'db/ar-sunlight-legislators.sqlite3'
end

desc "migrate the database (options: VERSION=x, VERBOSE=false, SCOPE=blog)."
task "db:migrate" do
  ActiveRecord::Migrator.migrations_paths << File.dirname(__FILE__) + 'db/migrate'
  ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
  ActiveRecord::Migrator.migrate(ActiveRecord::Migrator.migrations_paths, ENV["VERSION"] ? ENV["VERSION"].to_i : nil) do |migration|
    ENV["SCOPE"].blank? || (ENV["SCOPE"] == migration.scope)
  end
end


desc "create an ActiveRecord migration in ./db/migrate"
task "db:create_migration" do
  name = ENV['NAME']
  abort("no NAME specified. use `rake db:create_migration NAME=create_users`") if !name

  migrations_dir = File.join("db", "migrate")
  version = ENV["VERSION"] || Time.now.utc.strftime("%Y%m%d%H%M%S")
  filename = "#{version}_#{name}.rb"
  migration_name = name.gsub(/_(.)/) { $1.upcase }.gsub(/^(.)/) { $1.upcase }

  FileUtils.mkdir_p(migrations_dir)

  open(File.join(migrations_dir, filename), 'w') do |f|
    f << (<<-EOS).gsub("      ", "")
    class #{migration_name} < ActiveRecord::Migration
      def self.change
      end
    end
    EOS
  end
end

desc "populate the test database with sample data"
task "db:populate_legislators" do
  SunlightLegislatorsImporter.import
end

desc "populate the tweet database with data"
task "db:populate_tweets" do
  TweetsImporter.import
end

desc 'Retrieves the current schema version number'
task "db:version" do
  puts "Current version: #{ActiveRecord::Migrator.current_version}"
end

desc "Run the specs"
RSpec::Core::RakeTask.new(:specs)

task :default  => :specs
