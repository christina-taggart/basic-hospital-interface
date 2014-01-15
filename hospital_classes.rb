#-----HOSPITAL CLASS-----

class Hospital
  attr_reader :name

  def initialize(name)
    @name = name
    @employees = Hash.new
    @patients = Hash.new
  end

  def add_patient(patient)
    @patients[patient.id] = patient
  end

  def remove_patient(id)
    @patients.delete(id) { |id| puts "Patient #{id} not found."}
  end

  def get_patient_record(id)
    if has_patient?(id)
      @patients[id].print_record
    else
      puts "Patient not found."
    end
  end

  def get_all_patient_records
    @patients.each { |id, patient| patient.print_record }
  end

  def add_employee(employee)
    @employees[employee.id] = employee
  end

  def remove_employee(id)
    @employees.delete(id) { |id| puts "Employee #{id} not found."}
  end

  def get_employee_record(id)
     if has_employee?(id)
      @employees[id].print_record
    else
      puts "Employees not found."
    end
  end

  def get_all_employee_records
    @employees.each { |id, employee| employee.print_record }
  end

  private

  def has_patient?(id)
    return @patients[id] ? true : false
  end

  def has_employee?(id)
    return @employees[id] ? true : false
  end
end

#-----PATIENTS CLASS-----

class Patient
  attr_reader :id, :access_level

  def initialize(id, name, password, symptoms)
    @id = id
    @name = name
    @symptoms = symptoms
    @password = password
    @access_level = "patient"
  end

  def print_record
    puts "##{@id}. #{@name}, symptoms include:"
    @symptoms.each { |symptom| puts "- #{symptom}"}
    puts "------"
  end
end

#-----EMPLOYEES CLASSES-----

class Employee
  attr_reader :id, :access_level

  def initialize(id, name, password)
    @id = id
    @name = name
    @password = password
    @access_level = "employee"
  end

  def print_record
    puts "##{@id}. #{@name}, #{access_level}."
    puts "------"
  end
end

class Administrator < Employee
  def initialize(id, name, password)
    super
    @access_level = "administrator"
  end
end

class Doctor < Employee
  def initialize(id, name, password)
    super
    @access_level = "doctor"
  end
end


#-----DRIVERS-----
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

# mercy_hospital.get_all_patient_records
# mercy_hospital.get_all_employee_records

# puts "----Removing Joe...----"
# mercy_hospital.remove_employee(3)
# mercy_hospital.get_all_employee_records

# mercy_hospital.remove_patient(2)
# mercy_hospital.get_all_patient_records

# mercy_hospital.get_employee_record(4)
