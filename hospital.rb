class Hospital
	def initialize(name, location)
		@name = name
		@location = location
		@employees = []
		@patients = []
	end

	def admit_patient(patient)
		@patients << patient
	end

	def hire(*new_employees)
		new_employees.each do |employee|
			employee.hospital = self
			@employees << employee
		end
	end

	def to_s
		"#{@name}, #{@location}, \n" +
		"Employees: #{@employees.count}\n" +
		"Patients: #{@patients.count} \n"
	end

end


class Employee
	attr_reader :job_title, :salary
	attr_accessor :hospital
	def initialize(name, job_title, salary)
		@name = name
		@job_title = job_title
		@salary = salary
	end

	def to_s
		"#{@job_title} - #{@name}, salary: #{@salary} \n"
	end
end

class Doctor < Employee
	attr_accessor :patients
	def initialize(name, salary)
		@patients = []
		super(name, "Doctor", salary)
	end
end

class Janitor < Employee
	def initialize(name, salary)
		@tools = ["broom", "mop", "headphones"]
		super(name, "Janitor", salary)
	end
end

class Receptionist < Employee
	def initialize(name, salary)
		super(name, "Receptionist", salary)
	end

	def greet(name)
		puts "Welcome to the hospital, #{name}!"
	end

	def check_in_patient(patient, diagnosis, treatment, doctor)
		patient.diagnosis = diagnosis
		patient.treatment = treatment
		patient.doctor = doctor
		doctor.patients << patient
		@hospital.admit_patient(patient)
	end


end

class Patient
	attr_reader :name
	attr_accessor :diagnosis, :treatment, :doctor
	def initialize(name)
		@name = name
	end
end




mercy = Hospital.new("Mercy County Hospital", "Princeton Jct, New Jersey")
miranda = Doctor.new("Miranda", 120_000)
phyllis = Receptionist.new("Phyllis", 40_000)
ezekiel = Janitor.new("Ezekiel", 25_000)

mercy.hire(miranda, phyllis, ezekiel)

cheryl = Patient.new("Cheryl Blossom")
phyllis.greet(cheryl.name)
phyllis.check_in_patient(cheryl, "Broken Leg", "Cast", miranda)

puts mercy
p miranda.patients
p cheryl.doctor










