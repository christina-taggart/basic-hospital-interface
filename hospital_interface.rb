require_relative 'hospital_classes.rb'

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
    @user_access = gets.chomp
    if @user_access == "patient"
      interface if login(@hospital.patients)
    else
      interface if login(@hospital.employees)
    end
  end

  private

  def interface
    input = nil
    puts "Choose from the following options"
      puts "-get_my_record"
    until input == "exit"
      puts "Enter option: "
      input = gets.chomp
      if input == "get_my_record"
        puts
        @hospital.get_patient_record(@user.id)
      else
        puts
        puts "Invalid option."
      end
    end
    puts
    puts "EXITING INTERFACE."
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

  def valid_password?(test_pass, correct_pass)
    test_pass == correct_pass
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

#-----Let's interact with out hospital!-----

mercy_sys = HospitalInterface.new(mercy_hospital)

mercy_sys.run

