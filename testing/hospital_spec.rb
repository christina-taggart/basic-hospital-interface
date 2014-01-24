require_relative '../models/hospital'

# describe "color_enabled" do
#   context "when set with RSpec.configure" do
#     before do
#       # color is disabled for non-tty output, so stub the output stream
#       # to say it is tty, even though we're running this with cucumber
#       allow(RSpec.configuration.output_stream).to receive(:tty?) { true }
#     end

#     it "is true" do
#       expect(RSpec.configuration).to be_color_enabled
#     end
#   end
# end

describe Hospital do
	it "should return hospital name" do
		hospital_1 = Hospital.new('St. Hospitals', 'Good location #1', 50, 350)
		expect(hospital_1.name).to eq('St. Hospitals')
	end
	it "should return hostpital location" do
		hospital_1 = Hospital.new('St. Hospitals', 'Good location #1', 50, 350)
		expect(hospital_1.location).to eq('Good location #1')
	end
end

=begin
class Hospital
	attr_reader :name, :location
	def initialize(name, location, employee_num, patient_num)
		@name = name
		@location = location
		@employee_num = employee_num
		@patient_num = patient_num
	end	
=end