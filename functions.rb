class Password
	attr_accessor :password

	def initialize(password)
		@password = password		
	end

	def password_requirments()
		password[/[a-zA-Z0-9]{6,}/] == password
	end

	# def password_match(password)
	# 	if password.match(password)
	# 		true
	# 	else
	# 		false
	# 	end
	# end
end
