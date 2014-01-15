require_relative "../source/hospital.rb"
require_relative "../source/doctor.rb"
require_relative "../source/employee.rb"
require_relative "../source/janitor.rb"
require_relative "../source/receptionist.rb"
require_relative "../source/patient.rb"

describe Hospital do

  let(:hospital_name) { "St. Mary's" }
  let(:location_name) { "Springfield" }
  let(:hospital) { Hospital.new(hospital_name, location_name) }

  describe "when i create a new hospital" do
    it "should create a hospital" do
      expect(hospital).not_to be_nil
    end

    it "should have a name" do
      expect(hospital.name).to eq hospital_name
    end

    it "should have a location" do
      expect(hospital.location).to eq location_name
    end

    it "should have a number of employees" do
      expect(hospital.num_employees).to eq 0
    end

    it "should have a number of patients" do
      expect(hospital.num_patients).to eq 0
    end
  end
end

describe Patient do

  let(:patient_name) { "John Sickles" }
  let(:patient) { Patient.new(patient_name) }
  let(:healthy_message) { "Currently healthy" }

  describe "when I create a new patient" do
    it "should have a patient name" do
      expect(patient.name).to eq patient_name
    end

    it "should have a currently visiting status status of false" do
      expect(patient.is_visiting?).to be_false
    end

    it "should have a last visited of nil" do
      expect(patient.last_visited).to be_nil
    end

    it "should have current medications of empty array" do
      expect(patient.medications).to eq []
    end

    it "should have medicine allergies of empty array" do
      expect(patient.med_allergies).to eq []
    end

    it "should have diagnosis of healthy" do
      expect(patient.diagnosis).to eq healthy_message
    end
  end
end

describe Employee do
  let(:employee_name) { "John Smith" }
  let(:employee) { Employee.new(employee_name) }

  describe "when I create a new employee" do
    it "should have a name" do
      expect(employee.name).to eq employee_name
    end
  end
end


describe Doctor do
  let(:doctor_name) { "John Doctor" }
  let(:expertise) { "anesthesiology" }
  let(:doctor) { Doctor.new(doctor_name, expertise) }

  describe "when I create a new employee" do
    it "should have a name" do
      expect(doctor.name).to eq doctor_name
    end

    it "should have a expertise" do
      expect(doctor.expertise).to eq expertise
    end
  end
end


describe Receptionist do
  let(:receptionist_name) { "John Receptionist" }
  let(:receptionist) { Receptionist.new(receptionist_name) }

  describe "when I create a new employee" do
    it "should have a name" do
      expect(receptionist.name).to eq receptionist_name
    end
  end
end


describe Janitor do
  let(:janitor_name) { "John Janitor" }
  let(:janitor) { Janitor.new(janitor_name) }

  describe "when I create a new employee" do
    it "should have a name" do
      expect(janitor.name).to eq janitor_name
    end
  end
end