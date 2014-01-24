require 'rubygems'
require 'faker'
require 'activerecord'
require_relative '../models/patient'
require_relative '../models/employee'
require_relative '../models/hospital'

$hospital_1 = Hospital.new('St. Hospitals', 'Good location #1', 50, 350)

$hospital_1.patient_num.times do

end

def user_name
	user_name = Faker::Internet.user_name
end

def password 
	password = Faker::Internet.password
end

def company_name
	company_name = Faker::Company.Name
end

