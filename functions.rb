class Password
	attr_accessor :password

	def initialize(password)
		@password = password		
	end

	def password_requirments()
		password[/[a-zA-Z0-9]{6,}/] == password
	end

	def password_match(confirm)
		password.include?(confirm)
	end
end
