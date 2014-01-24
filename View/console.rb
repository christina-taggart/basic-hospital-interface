require_relative '../models/hospital'
require_relative '../models/interface'
require 'rubygems'
require 'highline/import'


$Hospital = Hospital.new('St. Hospitals', 'Good location #1', 50, 350)

class Console
	def self.get_user_name
		username = ask("Enter your username:  ") { |q| q.echo = true }
	end

	def self.get_password
		password = ask("Enter your password:  ") { |q| q.echo = "*" }
	end

	def self.print_messages
		puts "Welcome to #{$Hospital.name} Hospital"
		puts '-------------------------------------'
		puts 'Please enter your user_name:'
		user = get_user_name
		puts "\n"
		puts 'Please enter you password:'
		self.get_password
		puts "\n"
		puts '-------------------------------------'
		puts "Welcome, #{user}."
		puts '-------------------------------------'
	end


end

Console.print_messages