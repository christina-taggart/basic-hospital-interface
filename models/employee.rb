

class Employee
	attr_reader :type
	def initialize(job = {})
		@type = job[:type]
	end
end