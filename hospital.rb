require 'securerandom'
require 'pry'

class Hospital
	attr_reader :auth_system
	def initialize(name, location)
		@name = name
		@location = location
		@employees = []
		@patients = {}
		@generated_id = 0
		@auth_system = AuthSystem.new
	end

	def create_id
		@generated_id += 1
	end

	def check_in_patient(patient)
		patient.id = create_id
		patient.doctor.add_patient(patient)
		create_username_and_password(patient)
		@patients[patient.id] = patient
	end

	def check_out_patient(patient)
		patient.doctor.remove_patient(patient)
		@patients.delete(patient.id)
		@auth_system.delete(patient)
	end

	def hire(*new_employees)
		new_employees.each do |employee|
			create_username_and_password(employee)
			employee.hospital = self
			@employees << employee
		end
	end

	def create_username_and_password(person)
		person.username = person.name + SecureRandom.hex(2)
		person.password = SecureRandom.hex(4)
		@auth_system.add(person)
	end

	def create_admin(employee)
		employee.access_level = "ADMIN"
	end

	def to_s
		"#{@name}, #{@location}, \n" +
		"Employees: #{@employees.count}\n" +
		"Patients: #{@patients.count} \n"
	end

end

class AuthSystem
	def initialize
		@user_database = {}
	end

	def start_authentication_system
		puts "Welcome to #{@name}"
		puts "-" * 20
		username, password = login_prompt
		puts "-" * 20
		until valid_login?(username, password)
			"Invalid Login ID. "
			username, password = login_prompt
		end
		@current_user = @user_database[username]
		puts "Welcome, #{username}. Your access level is: #{@current_user.access_level}"

		if @current_user.access_level == "PATIENT"
			puts @current_user
		else
			while true
				display_options(@current_user.access_level)
				process_user_choice(gets.chomp)
			end
		end
	end

	def display_options(access_level)
		valid_access_levels = ["DOCTOR", "RECEPTIONIST", "PATIENT", "ADMIN"]
		unless valid_access_levels.include?(access_level)
			puts "Invalid access level."
			return
		end
		puts "What would you like to do?"
		puts "Options: "
		puts "l - list_patients"
		puts "v - view_patient <username>"

		if access_level == "ADMIN"
			puts "a - add_patient"
			puts "r - remove_patient <username>"
		end
	end

	def process_user_choice(input)
		choice, patient_username = input.split
		if choice == "l"
			list_patients
		elsif choice == "v"
			view_patient(patient_username)
		elsif choice == "a"
			add_patient
		elsif choice == "r"
			remove_patient(patient_username)
		else
			puts "Invalid Entry."
		end
	end

	def valid_login?(username, password)
		user = @user_database[username]
		return false unless user #guard clause

		user.password == password
	end

	def login_prompt
		puts "Please enter your username:"
		username = gets.chomp
		puts "Please enter your password:"
		password = gets.chomp
		[username, password]
	end

	def list_patients
		if @current_user.access_level == "RECEPTIONIST" || @current_user.access_level == "ADMIN"
			patients = @current_user.doctor.patients
		elsif @current_user.access_level == "DOCTOR"
			patients = @current_user.patients
		end

		puts patients.values.map {|patient| "#{patient.name}, #{patient.username}" }
	end

	def view_patient(patient_username)
		puts @user_database[patient_username]
	end

	def add_patient
		puts "Please enter patient's name: "
		name = gets.chomp
		puts "Diagnosis: "
		diagnosis = gets.chomp
		puts "Treatment plan:"
		treatment = gets.chomp
		puts "Doctor's username:"
		doctor_username = gets.chomp
		doctor = @user_database[doctor_username]
		@current_user.check_in_patient(Patient.new(name), diagnosis, treatment, doctor)
	end

	def remove_patient(patient_username)
		@current_user.check_out_patient(@user_database[patient_username])
	end

	def delete(user)
		@user_database.delete(user.username)
	end

	def add(user)
		@user_database[user.username] = user
	end
end


class Person
	attr_accessor :name, :username, :password, :access_level
	def initialize(name, access_level)
		@name = name
		@access_level = access_level
	end
end


class Employee < Person
	attr_reader :job_title, :salary
	attr_accessor :hospital
	def initialize(name, job_title, salary)
		super(name, job_title)
		@job_title = job_title
		@salary = salary
		@access_level = @job_title.upcase
	end

	def to_s
		"#{@job_title} - #{@name}, salary: #{@salary} \n" +
		"username: #{@username}, password: #{password}"
	end
end

class Doctor < Employee
	attr_reader :patients

	def initialize(name, salary)
		@patients = {}
		super(name, "Doctor", salary)
	end

	def remove_patient(patient)
		@patients.delete(patient.id)
	end

	def add_patient(patient)
		@patients[patient.id] = patient
	end
end

class Janitor < Employee
	def initialize(name, salary)
		@tools = ["broom", "mop", "headphones"]
		super(name, "Janitor", salary)
	end
end

class Receptionist < Employee
	attr_accessor :doctor
	def initialize(name, salary, doctor)
		super(name, "Receptionist", salary)
		@doctor = doctor
	end

	def greet(name)
		puts "Welcome to the hospital, #{name}!"
	end

	def check_in_patient(patient, diagnosis, treatment, doctor)
		patient.diagnosis = diagnosis
		patient.treatment = treatment
		patient.doctor = doctor
		@hospital.check_in_patient(patient)
	end

	def check_out_patient(patient)
		@hospital.check_out_patient(patient)
	end
end

class Patient < Person
	attr_accessor :diagnosis, :treatment, :doctor, :id
	def initialize(name)
		super(name, "PATIENT")
	end

	def to_s
		"Doctor: #{doctor.name}, ID: #{id}, Diagnosis: #{diagnosis}, Treatment: #{treatment}"
	end
end




mercy = Hospital.new("Mercy County Hospital", "Princeton Jct, New Jersey")
miranda = Doctor.new("Miranda", 120_000)
phyllis = Receptionist.new("Phyllis", 40_000, miranda)
mercy.create_admin(phyllis)
ezekiel = Janitor.new("Ezekiel", 25_000)

mercy.hire(miranda, phyllis, ezekiel)

cheryl = Patient.new("Cheryl")
phyllis.greet(cheryl.name)
phyllis.check_in_patient(cheryl, "Broken Leg", "Cast", miranda)

p cheryl.username
p cheryl.password
p phyllis.username
p phyllis.password
p miranda

mercy.auth_system.start_authentication_system










