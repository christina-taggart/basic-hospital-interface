class Hospital

	def initialize(name, location)
		@name = name
		@location = location
		@number_of_employees
		@number_of_patients
	end

end


class EmployeeRecords

	def self.employee_records(source_file)
		employees = []
		File.readlines(source_file).each_slice(5) do |s|
			employees << [s[0].strip, s[1].strip]
		end
		employees 
	end

end


# module organize_employees

# end



class Employees
	attr_accessor :janitors, :receptionists, :doctors, :patients
	def initialize
		@janitors = []
		@receptionists = []
		@doctors = []
		@patients = []
	end

	def total_number_of_employees
		@janitors.length + @receptionists.length + @doctors.length + @patients.length
	end

	def generate_patients
		@patients << Patient.new("George", "Collapsed Lung", "Surgery")
	end

end


class Patient #inherit from hospital or no?
	attr_reader :name, :diagnosis, :treatment
	def initialize(name, diagnosis, treatment)
		@name = name
		@diagnosis = diagnosis 
		@treatment = treatment
	end
end





mercy = Hospital.new("Mercy County Hospital", "Princeton Jct, New Jersey")
p mercy
mercy_employees = Employees.new
p mercy_employees.generate_patients



