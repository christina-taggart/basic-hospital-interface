class Hospital

  attr_reader :name, :employee_list

  def initialize(name, location, num_of_employees, num_of_patients)
    @name = name
    @location = location
    @num_of_employees = num_of_employees
    @num_of_patients = num_of_patients
    @patient_list = []
    @employee_list = []
  end

  def add_employee(employee)
    @employee_list << {:name => employee.name, :access_level => employee.access_level, :username => employee.username, :password => employee.password}
  end

  def add_patient(patient)
    @patient_list << {:name => patient.name, :username => patient.username, :password => patient.password, :ailment => patient.ailment, :room_num => patient.room_num, :access_level => "PATIENT"}
  end

   def authentic?(username)
    everyone = @patient_list + @employee_list
    everyone.each do |person|
      person.each do |label, value|
        if label == :username && value == username
          true
          @logged_in_name = person[:name]
          @username = person[:username]
          @password = person[:password]
          @access_level = person[:access_level]
          if person.has_key?(:ailment)
            @ailment = person[:ailment]
            @room_num = person[:room_num]
          end
        end
      end
    end
   end

  def authentication_system
    puts "Welcome to #{@name}"
    puts "-------------------------------"
    puts "Please enter your username:"
    username = gets.chomp
    puts "Please enter your password:"
    password = gets.chomp
    authentic?(username)
    if username == @username  && password == @password && @access_level != "JANITOR"
      puts "Welcome, #{@logged_in_name}. Your access level is: #{@access_level}"
    else
      puts "Your username and/or password is incorrect. You're probably not famous. Get out."
    end

    if @access_level == "DOCTOR" || @access_level == "NURSE"
      puts "----------------------------"
      puts "What would you like to do?"
      puts "Options:"
      puts "- list_patients"
      puts "- view_records <patient_id>"
      puts "- add_record <patient_id>"
      puts "- remove_record <patient_id> <record_id>"
    elsif @access_level == "PATIENT"
      puts "- view_records <patient_id>"
    end

    choice = gets.chomp
    if choice == "view records" && @access_level != "PATIENT"
      puts "Please enter patient name"
      name_to_get_records = gets.chomp
      view_records(name_to_get_records)
    elsif choice == "view records" && @access_level == "PATIENT"
      view_records(@logged_in_name)
    else
      puts "You fucked up"
    end
    #end
  end

  def view_records(name)
    if @access_level == "PATIENT" && name == @logged_in_name
      puts "#{@logged_in_name} has #{@ailment} and is in room number #{@room_num}"
    elsif @access_level == "DOCTOR" || @access_level == "NURSE"
      @patient_list.each do|person|
        person.each do |key, val|
          if val == name
            puts "Name: #{person[:name]}"
            puts "Ailment: #{person[:ailment]}"
            puts "Room Number: #{person[:room_num]}"
          end
        end
      end
    end
  end
end

class Patient

  attr_reader :name, :username, :password, :ailment, :room_num

  def initialize(name, username, password, ailment, room_num)
    @name = name
      if @name.include?(" ")
        raise ArgumentError.new("Sorry, you're not famous enough. Try some peasant hospital.")
      end
    @ailment = ailment
    @room_num = room_num
    @username = username
    @password = password
    @access_level = "PATIENT"
  end

end

class Employees
  attr_reader :name, :access_level, :username, :password

  def initialize(name, access_level, username, password)
    @name = name
    @access_level = access_level
    @username = username
    @password = password
  end
end


#------------------------------------------------------------------------
real_hospital_of_atlanta = Hospital.new("The Real Hospital of Atlanta", "Bravo TV", 5, 5)
real_hospital_of_atlanta.add_employee(Employees.new("Dr. Dre", "DOCTOR", "dre", "beats"))
real_hospital_of_atlanta.add_employee(Employees.new("Kanye West", "JANITOR","genius_and_master_of_universe","north"))
real_hospital_of_atlanta.add_patient(Patient.new("Sting", "sting","yoga","Tantric adventure injury", "1"))
real_hospital_of_atlanta.add_patient(Patient.new("Kesha", "jack","diddy","Glitter poisoning", "2"))
real_hospital_of_atlanta.add_patient(Patient.new("Madonna", "material_girl","kabbalah","Arms got too jacked", "3"))
real_hospital_of_atlanta.authentication_system

