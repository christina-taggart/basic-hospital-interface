class Hospital
  attr_reader :name
  attr_accessor :employees, :patients

  def initialize(name, location)
    @name = name
    @location = location
    @employees = []
    @patients = []
    @message = ""
  end

  def validate
    puts "Welcome to #{name}"
    puts "--------------------"
    puts "Please enter your username:\n"
    user_name = gets.chomp
    puts "Please enter your password:\n"
    password = gets.chomp
    puts "--------------------"
    @employees.select do |employee|
      if employee.user_name == user_name && employee.password == password
        @clearance = employee.clearance
        puts "Welcome, #{employee.user_name}. Your access level is: #{employee.clearance}"
        puts "What would you like to do?"

        display_options(employee.clearance)
        get_user_input
      end
    end
  end

  def display_options(clearance_level)
    puts " "
    puts "Options:"
    options = ["- list_patients", "- view_records <patient id>", "- add_record <patient id>", "- remove_record <patient_id> <record_id>"]
    if clearance_level == 3
      options.each{|command| puts command}
    elsif clearance_level == 2
      options[0..-3].each{|command| puts command}
    else
      puts options[0]
    end
  end

  def get_user_input
    user_input = gets.chomp.split(" ")
    while user_input.first != "exit"
      gui(user_input)
      display_options(@clearance)
      user_input = gets.chomp.split(" ")
    end
  end

  def gui(user_input)
    command = user_input.shift
    @message = user_input
    send(command)
  end

  def list_patients
    @patients.each { |patient| p "#{patient.name}, #{patient.id}" }
  end

  def view_records
    if @clearance > 1
      @patients.each do |patient|
        if patient.id == @message[0].to_i
          patient.records.each{|id, record| puts record}
        end
      end
    else
      puts "You do not have proper clearance."
    end
  end

  def add_record
    if @clearance > 2
      @patients.each do |patient|
        if patient.id == @message[0].to_i
          patient.add_record(@message[1..-1].join(" "))
        end
      end
    else
      puts "You do not have proper clearance."
    end
  end

  def remove_record
    if @clearance > 2
      @patients.each do |patient|
        if patient.id == @message[0].to_i
          patient.records.delete(@message[1].to_i)
        end
      end
    else
      puts "You do not have proper clearance."
    end
  end

end



class Patient
  attr_reader :name, :id, :records

  def initialize(name, id)
    @name = name
    @id = id
    @records = {}
  end

  def add_record(message)
    @records[records.length + 1] = message
  end

end



class Employee
  attr_reader :user_name, :clearance, :occupation, :password

  def initialize(user_name, password)
    @user_name = user_name
    @password = password
  end
end

class Doctor < Employee
  def initialize(user_name, password)
    super(user_name, password)
    @clearance = 3
    @occupation = "Doctor"
  end
end

class Receptionist < Employee
  def initialize(user_name, password)
    super(user_name, password)
    @clearance = 2
    @occupation = "Receptionist"
  end
end

class Janitor < Employee
  def initialize(user_name, password)
    super(user_name, password)
    @clearance = 1
    @occupation = "Janitor"
  end
end

jan_the_janitor = Janitor.new("Jan", "foobar")
dave_the_doctor = Doctor.new("Dave", "foobar")
hospital = Hospital.new("hosipal", "LA")
hospital.employees << jan_the_janitor
hospital.employees << dave_the_doctor
eli = Patient.new("Eli", 1)
eli.add_record("Herpes")
eli.add_record("Diareeah")
hospital.patients << eli
hospital.patients << Patient.new("Roy", 2)
hospital.validate