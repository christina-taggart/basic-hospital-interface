class Hospital
  attr_reader :name, :location, :patients, :employees

  def initialize(name, location)
    @name = name
    @location = location
    @patients = []
    @employees = []
  end

  def add_patient(patient)
    @patients[patient.name] = {condition: patient.condition, admitted: Time.now, discharged: nil }
  end

  def add_employee(employee)
    @employees << employee
  end

  def authenticate
    puts "Enter Username: \n"
    username = gets.chomp
    puts "Enter Password: \n"
    password = gets.chomp

    @employees.each do |employee|
      if employee.username == username && employee.password == password
        employee.logged_in? = true
        employee.log_in_message
      end
    end
  end

  def list_patients

  end

  def view_record(patient_id)

  end

  def add_record(patient_id)

  end

  def remove_record(patient_id)

  end

  # in the log in system level 3 can list patients, view records, add records, remove records
  # in the log in system level 2 can add records, remove records
  # in the log in system level 1 can add records

end


class Patient

  def initialize(name, condition)
    @name = name
    @condition = condition
    @records = {}
  end

end


class Employee
  attr_reader :name, :username, :position, :access_level
  attr_accessor :logged_in?

  def initialize(name, username, password)
    @name = name
    @username = username
    @position = nil
    @password = nil
    @access_level = 0
    @logged_in? = false
  end

  def logged_in_message
    puts "Hello #{name}, you are logged in with access level - #{access_level}"
  end

end

class Doctor < Employee

  def initialize(name, username, password)
    super
    @position = "Doctor"
    @access_level = 3
  end

  def logged_in_message
    super
    puts "What would you like to do?"
    puts "Options:"
    puts "- list_patients"
    puts "- view_records <patient_id>"
    puts "- add_record <patient_id>"
    puts "- remove_record <patient_id> <record_id>"
  end


end

class Admin < Employee

  def initialize(name, username, password)
    super
    @position = "Admin"
    @access_level = 2
  end

  def logged_in_message
    super
    puts "What would you like to do?"
    puts "Options:"
    puts "- add_record <patient_id>"
    puts "- remove_record <patient_id> <record_id>"
  end

end

class Janitor < Employee

  def initialize(name, username, password)
    super
    @position = "Janitor"
    @access_level = 1
  end

  def logged_in_message
    super
    puts "What would you like to do?"
    puts "Options:"
    puts "- add_record <patient_id>"
  end

end

hells_pass = Hospital.new("Hell's Pass", "Burma")
doc = Doctor.new("Dr. Shkurkin", "Shkurkin", "8675309")
p doc.access_level