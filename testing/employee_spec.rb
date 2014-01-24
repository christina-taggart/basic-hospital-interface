require_relative '../models/employee'

describe Employee do
	it "should return Employee name" do
		employee_1 = Employee.new(type: 'Doctor')
		expect(employee_1.type).to eq('Doctor')
	end
end