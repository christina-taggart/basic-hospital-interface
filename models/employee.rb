

class Employee
	attr_reader :type, :user_name
	def initialize(info = {})
		@type = info[:type]
		@user_name = info[:user_name] 
		@password = info[:password]
	end
end