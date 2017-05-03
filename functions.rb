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

# 	def login_match?(log_username, log_password)

# 		db_params = {

#     host: ENV['host'],
#     port: ENV['port'],
#     dbname: ENV['db_name'],
#     user: ENV['user'],
#     password: ENV['password']
# 		}

# 		db = PG::Connection.new(db_params)

# 	results = false

# 	check_login = db.exec("SELECT username, password FROM accounts WHERE username = '#{session[:username]}'")

#     password = check_login[0]['password']
#     unhashed_pass = BCrypt::Password.new(password)

#     if check_login[0]['username'] == log_username &&  unhashed_pass == log_password
#        results = true
#     end      
# 	results
# end


end
