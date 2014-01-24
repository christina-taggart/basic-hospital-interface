

class Patient
	attr_reader :name, :id
	def initialize(name, id, illness, billing_address)
		@name = name
		@id = id
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