class PasswordReqClass
	attr_accessor :password

	def initialize(password)
		@password = password		
	end

	def password_requirements()
		password[/[a-zA-Z0-9]{6,}/] == password
	end
	#password function. Can only contain letters, numbers and no less than 6 characters.
	def password_match(confirm)
		password.include?(confirm)
	#password confirm function. When signing up making sure passwords match	
	end
end
