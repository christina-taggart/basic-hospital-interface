

class Hospital
	attr_reader :name, :location, :employee_num, :patient_num
	def initialize(name, location, employee_num, patient_num)
		@name = name
		@location = location
		@employee_num = employee_num
		@patient_num = patient_num
	end
end