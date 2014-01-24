require_relative '../models/patient'

describe Patient do
	it "should return Patient name" do
		patient_1 = Patient.new('John', 1, "tummy ache", "the poor side of town")
		expect(patient_1.name).to eq('John')
	end
	it "should return hostpital location" do
		patient_1 = Patient.new('John', 1, "tummy ache", "the poor side of town")
		expect(patient_1.id).to eq(1)
	end
end