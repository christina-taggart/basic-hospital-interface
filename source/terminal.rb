require 'csv'

class Terminal

	def initialize(accounts_file)
		@passwords = {}
		@roles = {}
		load_accounts(accounts_file)
		@current_role = nil
		@logged_in = false
	end

	def run!
		get_login until logged_in?
		prompt_menu while logged_in?
	end

	def get_login
		puts "Enter username: "
		username = gets.chomp
		puts "Enter password: "
		password = gets.chomp

		authenticate_password(username, password)
	end

	def load_accounts(accounts_file)
		@passwords = {}
		CSV.foreach(accounts_file) do |row|
			@passwords[row[0]] = row[1]
			@roles[row[0]] = row[2]
		end
		@passwords
	end

	def authenticate_password(user, pass)
		@logged_in = (@passwords[user] == pass)
		@current_role = @roles[user]
	end

	def prompt_menu
		p "Hi there. Your access level is: #{@current_role}"
		p "Command: "
		input = gets.chomp
		@logged_in = false if input == 'exit'
	end

	def logged_in?
		@logged_in
	end
end