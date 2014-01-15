require_relative 'hospital_classes.rb'

#-----An interface for manipulating the Hospital Class-----

class HospitalInterface
  def initialize(hospital)
    @hospital = hospital
    @user_access = nil
    @user = nil
  end

  def run
    puts "----------#{@hospital.name.upcase}----------"
    puts
    puts "Enter your access level"
    puts "(patient/doctor/administrator/employee): "
    until valid_access?(@user_access)
      @user_access = gets.chomp
      if @user_access == "patient"
        interface if login(@hospital.patients)
      elsif valid_access?(@user_access)
        interface if login(@hospital.employees)
      else
        puts "Invalid option."
      end
    end
  end

  private

  def interface
    input = nil
    list_interface_options
    until input == "exit"
      puts
      puts "Enter option: "
      input = gets.chomp
      if input == "exit"
        puts
        puts "EXITING INTERFACE."
      elsif input == "get my record"
        get_my_record_interface
      elsif input == "help"
        list_interface_options
      elsif input == "get all patient records" && (doctor_access? || admin_access?)
        puts
        @hospital.get_all_patient_records
      elsif input == "get patient record" && (doctor_access? || admin_access?)
        get_patient_interface
      elsif input == "get all employee records" && admin_access?
        puts
        @hospital.get_all_employee_records
      elsif input == "get employee record" && admin_access?
        get_employee_interface
      elsif input == "add patient" && admin_access?
        add_patient_interface
      elsif input == "remove patient" && admin_access?
        remove_patient_interface
      elsif input == "add employee" && admin_access?
        add_employee_interface
      elsif input == "remove employee" && admin_access?
        remove_employee_interface
      else
        puts
        puts "Invalid option."
      end
    end 
  end

  def login(database)
    puts "Enter your ID number:"
    id = (gets.chomp).to_i
    @user = database[id]
    if @user
      puts "Enter your password:"
      password = gets.chomp
      if valid_password?(password, @user.password)
        puts
        puts "LOGGING IN..."
        true
      else
        puts
        puts "Invalid password."
        puts "EXITING INTERFACE."
        false
      end
    else
      puts
      puts "Invalid ID."
      puts "EXITING INTERFACE."
      false
    end
  end

  def list_interface_options
    puts
    puts "Choose from the following options"
    puts "- help"
    puts "- get my record"
    if doctor_access? || admin_access?
      puts "- get all patient records"
      puts "- get patient record"
    end
    if admin_access?
      puts "- get all employee records"
      puts "- get employee record"
      puts "- add patient"
      puts "- remove patient"
      puts "- add employee"
      puts "- remove employee"
    end
  end

  def get_my_record_interface
    puts
    if @user_access == "patient"
      puts
      @hospital.get_patient_record(@user.id)
    else
      puts
      @hospital.get_employee_record(@user.id)
    end
  end

  def get_patient_interface
    puts "Enter patient ID:"
    patient_id = (gets.chomp).to_i
    puts
    @hospital.get_patient_record(patient_id)
  end

  def get_employee_interface
    puts "Enter employee ID:"
    employee_id = (gets.chomp).to_i
    puts
    @hospital.get_patient_record(employee)
  end

  def add_patient_interface
    puts "Enter patient ID:"
    id = (gets.chomp).to_i
    puts "Enter patient name:"
    name = gets.chomp
    puts "Enter patient password:"
    password = gets.chomp
    puts "Enter symptoms (separated by spaces):"
    symptoms = gets.chomp
    symptoms = symptoms.split(" ")
    new_patient = Patient.new(id, name, password, symptoms)
    @hospital.add_patient(new_patient)
    puts "PATIENT ADDED."
  end

  def add_employee_interface
    puts "Enter employee ID:"
    id = (gets.chomp).to_i
    puts "Enter employee name:"
    name = gets.chomp
    puts "Enter employee password:"
    password = gets.chomp
    puts "Enter employee type (administrator/doctor/employee):"
    type = gets.chomp
    if type == "employee"
      new_employee = Employee.new(id, name, password)
    elsif type == "doctor"
      new_employee = Doctor.new(id, name, password)
    elsif type == "administrator"
      new_employee = Administrator.new(id, name, password)
    end
    @hospital.add_employee(new_employee)
    puts "EMPLOYEE ADDED."
  end

  def remove_patient_interface
    puts "Enter patient ID:"
    patient_id = (gets.chomp).to_i
    @hospital.remove_patient(patient_id)
    puts "PATIENT REMOVED."
  end

  def remove_employee_interface
    puts "Enter employee ID:"
    employee_id = (gets.chomp).to_i
    @hospital.remove_employee(employee_id)
    puts "EMPLOYEE REMOVED."
  end

  def doctor_access?
    @user_access == "doctor" ? true : false
  end

  def admin_access?
    @user_access == "administrator" ? true : false
  end

  def valid_password?(test_pass, correct_pass)
    test_pass == correct_pass
  end

  def valid_access?(test_input)
    correct_options = ["patient", "doctor", "administrator", "employee"]
    if correct_options.include?(test_input)
      true
    else
      false
    end
  end
end


#-----EXAMPLE HOSPITAL-----
mike = Patient.new(1, "Mike Jones", "password", ["sore throat", "dizzinees"])
sarah = Patient.new(2, "Sarah Smith", "password", ["double vision", "nausea"])
peter = Patient.new(3, "Peter Piper", "password", ["cataracts", "stuffy nose"])
john = Administrator.new(1, "John Olmsted", "pineapple")
amy = Doctor.new(2, "Amy Ruby", "iamadoctor")
joe = Employee.new(3, "Joe Schmo", "hoot")

mercy_hospital = Hospital.new("Mercy Hospital")
mercy_hospital.add_patient(mike)
mercy_hospital.add_patient(sarah)
mercy_hospital.add_patient(peter)
mercy_hospital.add_employee(john)
mercy_hospital.add_employee(amy)
mercy_hospital.add_employee(joe)

#-----Let's interact with our hospital!-----

mercy_sys = HospitalInterface.new(mercy_hospital)

mercy_sys.run

