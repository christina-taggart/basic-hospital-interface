class Hospital
  attr_reader :patient_data , :employee_data, :patients, :employees
  def initialize(name, location)
    @patients = []
    @employees = []
    @patient_data = {}
    @employee_data = {}
  end

  def admit_patients(sick_person)
    @patients << sick_person
    @patient_data[sick_person.name] = sick_person.info
  end

  def discharge_patients(sick_person)
    @patients.delete(sick_person)
    sick_person.info["condition"] = :healthy
  end

  def hire_employees(person)
    @employees << person
    @employee_data[person.name] = person.info
  end

  def fire_employees(person)
    @employees.delete(person)
  end
end


class Person
  attr_accessor :name, :access_level, :info
  def initialize(username, password)
    @username = username
    @password = password
    @access_level = 0
    @name = username
    @info = {}
  end
end


class Patient < Person
  attr_accessor :info, :access_level
  def initialize(username, password)
    @access_level = 1
    super(username, password)
    @info = {username => password, "condition" => :sick}
  end
end

class Employee < Person
  attr_accessor :info
  def initialize(username, password, access_level)
    puts "1"
    super(username, password)
    puts "2"
    @info = {username => password, "access" =>  access_level}
    # @position = position
  end
end


class Admin < Employee
  def initialize(username, password)
    super(username, password, 3)
    #username, password, acccess level, position
  end
end

class Doctor < Employee
  def initialize(username, password)
    super(username, password, 2)
    #username, password, acccess level, position
  end
end

class Nurse < Employee
  def initialize(username, password)
    super(username, password, 2)
    #username, password, acccess level, position
  end
end

class Receptionist < Employee
  def initialize(username, password)
    super(username, password, 2)
    #username, password, acccess level, position
  end
end

class Janitor < Employee
  def initialize(username, password)
    super(username, password, 0)
    #username, password, acccess level, position
  end
end

class Interface
  attr_accessor :access_level , :patient, :employee, :hospital
  def initialize(hospital)
    @hospital = hospital
    puts "Please Enter Username:"
    input_un = gets.chomp
    puts "Please Enter your password"
    input_pw = gets.chomp

    if hospital.patient_data.has_key?(input_un)
      if hospital.patient_data[input_un][input_un] == input_pw
        @patient = true
      end
    elsif hospital.employee_data.has_key?(input_un)
      if hospital.employee_data[input_un][input_un] == input_pw
        @employee = true
      end
    else
      puts "Access denied"
    end

    if @patient
      @access_level = 1
    else
      @access_level = @hospital.employee_data[input_un]["access"]
    end
  end

  def list_patient
    @hospital.patients.map{|patient| puts patient.name}
  end

  def view_records(patient_un)
    @hospital.patient_data[patient_un].each {|x, y| puts x}
  end

  def add_records(patient_un)
   new_patient = Patient.new(patient_un, "password")
   @hospital.patients << new_patient
   @hospital.patient_data[patient_un] = new_patient.info
  end

  def remove_record(patient_un)
    @hospital.patient_data.delete(patient_un)
  end


  def interact
    puts "Options:"
    puts "list patients" if @access_level > 1
    puts "view records" if @access_level > 1
    puts "add records" if @access_level > 1
    puts "remove record" if @access_level > 1

    input = gets.chomp

    if input == "list patients"
      list_patient
    elsif input == "view records"
      puts "enter patient name"
      patient = gets.chomp
      view_records(patient)
    elsif input == "add records"
      puts "enter patient name"
      patient = gets.chomp
      add_records(patient)
    elsif input == "remove record"
      puts "enter patient name"
      patient = gets.chomp
      remove_record(patient)
    else
      puts "invalid command"
    end
  end
end

hospital = Hospital.new("HS", "San francisco")

andy = Patient.new("andy", "lee")
nic = Doctor.new("asdf", "asdf")


hospital.admit_patients(andy)
hospital.hire_employees(nic)


interface = Interface.new(hospital)
interface.interact


