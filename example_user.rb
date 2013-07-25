class User
	attr_accessor :name, :email

	def initialize(sing = {})
		@name = sing[:name]
		@email = sing[:email]
	end

	def formatted_email
		"#{@name} <#{@email}>"
	end
end