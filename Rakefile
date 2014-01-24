require 'rake'
require 'rspec/core/rake_task'
require 'faker'
require 'csv'
require_relative 'lib/employee_importer'
require_relative 'lib/patient_importer'
require_relative 'db/config'

desc "create the database"
task "db:create" do
  touch 'db/medical.sqlite3'
end

desc "drop the database"
task "db:drop" do
  rm_f 'db/medical.sqlite3'
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

desc "populate the patient database with data"
task "db:populate_patients" do
  PatientImporter.import
end

desc "populate the employee database with data"
task "db:populate_employees" do
  EmployeeImporter.import
end

desc 'Retrieves the current schema version number'
task "db:version" do
  puts "Current version: #{ActiveRecord::Migrator.current_version}"
end

desc "creates fake patients"
task "db:create_patients" do
    CSV.open("db/data/patients.csv", "wb") do |csv|
        100.times do
          csv << ["#{Faker::Internet.user_name}", "#{Faker::Internet.password}"]
        end
    end
end

desc "creates fake employees"
task "db:create_employees" do
    CSV.open("db/data/employees.csv", "wb") do |csv|
        100.times do
          csv << ["#{Faker::Internet.user_name}", "#{Faker::Internet.password}"]
        end
    end
end
desc "Run the specs"
RSpec::Core::RakeTask.new(:specs)

task :default  => :specs
