

class Patient
	attr_reader :user_name
	def initialize(user_name, password, illness, billing_address)
		@user_name = user_name
		@password = password
		@illness = illness
		@billing_address = billing_address
	end

	private

	def illness
		@illness
	end

	def billing_address
		@billing_address
	end
end