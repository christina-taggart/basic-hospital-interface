require_relative '../db/config'


class Patient < ActiveRecord::Base
	attr_reader :user_name
	def initialize(info = {}) #, illness, billing_address)
		@user_name = info[:user_name]
		@password = info[:password]
		# @illness = illness
		# @billing_address = billing_address
	end

	# private

	# def illness
	# 	@illness
	# end

	# def billing_address
	# 	@billing_address
	# end
end