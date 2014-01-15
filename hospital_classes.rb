#-----HOSPITAL CLASS-----

class Hospital
  def initialize
    employees = Hash.new
    patients = Hash.new
  end

  def add_patient(patient)
    patients[patient.id] = patient
  end

  def remove_patient(id)
    patients.delete(id) { |id| puts "#Patient #{id} not found."}
  end

  def add_employee

  end

  def remove_employee

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
    puts "------"
    puts "##{@id}. #{@name}, symptoms include:"
    @symptoms.each { |symptom| puts "- #{symptom}"}
    puts "------"
  end
end

#-----EMPLOYEES CLASSES-----



#-----DRIVERS-----
mike = Patient.new(1, "Mike Jones", "password", ["sore throat", "dizzinees"])
mike.print_record