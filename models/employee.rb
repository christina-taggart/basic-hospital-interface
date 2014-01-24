require_relative '../db/config'


class Employee < ActiveRecord::Base
	attr_reader :type, :user_name, :password
	def initialize(info = {})
		@type = info[:type]
		@user_name = infio[:user_name]
		@password = info[:password]
	end
end

