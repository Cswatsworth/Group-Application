require 'pg'
load './local_env.rb' if File.exists?('./local_env.rb')

def valid_password?(password)
	password.to_s.length > 5
end

def email_not_unique?(new_email)
	db_params = {
    host: ENV['host'],
    port: ENV['port'],
    dbname: ENV['db_name'],
    user: ENV['user'],
    password: ENV['password']
	}

	db = PG::Connection.new(db_params)

	dbname=db.exec("SELECT email FROM accounts")
	results = false
	dbname.each do |item|
		if item['email'] == new_username
			results = true
		end
	end
	results
end



def login_match?(log_email, log_password)
		db_params = {
    host: ENV['host'],
    port: ENV['port'],
    dbname: ENV['db_name'],
    user: ENV['user'],
    password: ENV['password']
		}

		db = PG::Connection.new(db_params)
	
	results = false

	check_login = db.exec("SELECT email, password FROM personalinfo WHERE email = '#{session[:email]}' AND password='#{session[:password]}'")

    password = check_login[0]['password']
    unhashed_pass = BCrypt::Password.new(password)

    if check_login[0]['email'] == log_email &&  unhashed_pass == log_password
       results = true
    end      
	results
end



# class PasswordReqClass
# 	attr_accessor :password

# 	def initialize(password)
# 		@password = password		
# 	end

# 	def password_requirements()
# 		password[/[a-zA-Z0-9]{6,}/] == password
# 	end
# 	#password function. Can only contain letters, numbers and no less than 6 characters.
# 	def password_match(confirm)
# 		password.include?(confirm)
# 	#password confirm function. When signing up making sure passwords match	
# 	end

