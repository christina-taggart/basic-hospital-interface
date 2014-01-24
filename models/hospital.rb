

class Hospital
	attr_reader :name, :location
	def initialize(name, location, employee_num, patient_num)
		@name = name
		@location = location
		@employee_num = employee_num
		@patient_num = patient_num
	end

	private

	def number_of_employees
		@employee_num
	end

	def number_of_patients
		@patient_num
	end
end