require 'sinatra'
require 'pg'
require_relative 'functions.rb'
require 'net/smtp'


load './local_env.rb' if File.exists?('./local_env.rb')

db_params = {
    host: ENV['host'],
    port: ENV['port'],
    dbname: ENV['db_name'],
    user: ENV['user'],
    password: ENV['password']
}

db = PG::Connection.new(db_params)

	enable :sessions

	# get '/' do
	# 	session_email = session[:email]
 #        session_password = session[:password]
 #        if (session_email == nil || session_password == nil)
	#         login = db.exec("SELECT email, password FROM login");
	# 		erb :login_erb, locals: {login: login}   
 #        else
 #            redirect '/p_info'
 #        end
	# end


	get '/' do
		login = db.exec("SELECT email, password FROM login");
		erb :login_erb, locals: {login: login}
	end


	post'/login' do
		session[:email] = params[:email]
		session[:password] = params[:password]
		session[:psw_req] = PasswordReqClass.new(params[:password])

			if session[:psw_req].password_requirements == false
				 "Password"
			else

		db.exec("INSERT INTO login(email, password) VALUES('#{session[:email]}', '#{session[:password]}')");
		first = ""
		last = ""
		street = ""
		city = ""
		state = ""
		zip = ""
		phonenumber = ""
		db.exec("INSERT INTO personalinfo(email, password, first, last, street, city, state, zip, phonenumber) VALUES('#{session[:email]}', '#{session[:password]}', '#{first}', '#{last}', '#{street}', '#{city}', '#{state}', '#{zip}', '#{phonenumber}')");
		redirect '/p_info'
		end
	end

	get '/p_info' do
		personalinfo = db.exec("SELECT first, last, street, city, state, zip, phonenumber, email FROM personalinfo");
		erb :p_info, locals: {personalinfo: personalinfo}
	end

	post '/personalinfo' do
		session[:first] = params[:first]
		session[:last] = params[:last]
		session[:street] = params[:street]
		session[:city] = params[:city]
		session[:state] = params[:state]
		session[:zip] = params[:zip]
		session[:phonenumber] = params[:phonenumber]
		
		db.exec("UPDATE personalinfo SET first='#{session[:first]}', last='#{session[:last]}', street='#{session[:street]}', city='#{session[:city]}', state='#{session[:state]}', zip='#{session[:zip]}', phonenumber='#{[:phonenumber]}' WHERE email='#{session[:email]}'");
		redirect '/questionpg1'
	end

	get '/questionpg1' do
		questions = db.exec("SELECT question1, question2, question3, question4, question5, email FROM questions");
		erb :questionpg1, locals: {questions: questions}
	end

	post '/questions' do
		session[:question1] = params[:question1]
		session[:question2] = params[:question2]
		session[:question3] = params[:question3]
		session[:question4] = params[:question4]
		session[:question5] = params[:question5]
		question6 = ""
		question7 = ""
		question8 = ""
		question9 = ""
		question10 = ""
		question11 = ""
		question12 = ""
		question13 = ""
		question14 = ""
		question15 = ""
		question16 = ""
		question17 = ""
		question18 = ""
		question19 = ""
		question20 = ""
		db.exec("INSERT INTO questions(question1, question2, question3, question4, question5, question6, question7, question8, question9, question10, question11, question12, question13, question14, question15, question16, question17, question18, question19, question20, email) VALUES('#{session[:question1]}', '#{session[:question2]}', '#{session[:question3]}', '#{session[:question4]}', '#{session[:question5]}', '#{question6}', '#{question7}', '#{question8}', '#{question9}', '#{question10}', '#{question11}', '#{question12}', '#{question13}', '#{question14}', '#{question15}', '#{question16}', '#{question17}', '#{question18}', '#{question19}', '#{question20}', '#{session[:email]}')");

		redirect '/questionpg2'
	end

	get '/questionpg2' do
		questions = db.exec("SELECT question6, question7, question8, question9, question10, email FROM questions");
		erb :questionpg2, locals: {questions: questions}
	end

	post '/questions1' do
		session[:question6] = params[:question6]
		session[:question7] = params[:question7]
		session[:question8] = params[:question8]
		session[:question9] = params[:question9]
		session[:question10] = params[:questio10]
		
		db.exec("UPDATE questions SET question6='#{session[:question6]}', question7='#{session[:question7]}', question8='#{session[:question8]}', question9='#{session[:question9]}', question10='#{session[:question10]}' WHERE email='#{session[:email]}'");

		redirect '/questionpg3'
	
	end

	get '/questionpg3' do
		questions = db.exec("SELECT question11, question12, question13, question14, question15, email FROM questions");
		erb :questionpg3, locals: {questions: questions}
	end

	post '/questions2' do
		session[:question11] = params[:question11]
		session[:question12] = params[:question12]
		session[:question13] = params[:question13]
		session[:question14] = params[:question14]
		session[:question15] = params[:question15]


		db.exec("UPDATE questions SET question11='#{session[:question11]}', question12='#{session[:question12]}', question13='#{session[:question13]}', question14='#{session[:question14]}', question15='#{session[:question15]}' WHERE email='#{session[:email]}'");

		if  
			p "Please Answer Atleast One!"
		end

		redirect '/questionpg4'
	end

	get '/questionpg4' do
		questions = db.exec("SELECT question16, question17, question18, question18, question20, email FROM questions");
		erb :questionpg4, locals: {questions: questions}
	end

	post '/questions3' do
		session[:question16] = params[:question16]
		session[:question17] = params[:question17]
		session[:question18] = params[:question18]
		session[:question19] = params[:question19]
		session[:question20] = params[:question20]
		
		db.exec("UPDATE questions SET question16='#{session[:question16]}', question17='#{session[:question17]}', question18='#{session[:question18]}', question19='#{session[:question19]}', question20='#{session[:question20]}' WHERE email='#{session[:email]}'");
		redirect '/review'
	end

	get '/review' do
		erb :review
	end


	post '/send_email' do

		send_email		
		#Might need to tweak this to redirect to desired page or create an email successfully sent page
		redirect '/complete'
	end

	get '/complete' do
		erb :complete

	end

		#****JOSEPH****Was trying a different approach here***
	get '/account' do
		signin = db.exec("SELECT * FROM public.personalinfo WHERE email='#{session[:email]}' AND password='#{session[:password]}'");
		erb :account
	end

	post '/account' do 
		db.exec("UPDATE personalinfo SET first='#{session[:first]}', last='#{session[:last]}', street='#{session[:street]}', city='#{session[:city]}', state='#{session[:state]}', zip='#{session[:zip]}', phonenumber='#{[:phonenumber]}' WHERE email='#{session[:email]}'");
		redirect '/account'
	end

#**JOSEPH**IGNORE THIS (LINE 180-191)
=begin
	post '/account' do				
	 	accountinfo = db.exec("SELECT p.first, p.last, p.street, p.state, p.city, p.zip, p.phonenumber, p.email 
	 							FROM login l
	 							INNER JOIN personalinfo p ON p.email = l.email
	 							WHERE l.email='#{params[:email]}' AND l.password='#{params[:password]}'")

	 	erb :login_erb, locals: {accountinfo: accountinfo}		 	
	 	redirect '/p_info'	 	
	end
=end

	get '/account' do
		erb :account
	end



   	post '/account' do
        session_email = session[:email]
        session_password = session[:password]
        if (session_email == nil || session_password == nil)
            email = params[:email]
            password = params[:password]
            sql = "SELECT email FROM login WHERE email = '#{email}' AND password = '#{password}'"
            puts "Email: #{email}"
            puts "Password: #{password}"
            puts sql
            account = db.exec(sql)
            if account.num_tuples == 0
                puts "get out of here"
                redirect '/account'
            else
                puts "Sweet baby jesus"
                session[:email] = params[:email]
                session[:password] = params[:password]
                sql = "SELECT * FROM personalinfo WHERE email = '#{email}'"
                accountinfo = db.exec(sql)
                erb :account, locals: {account: account}
                redirect '/account'
            end
        else
            puts "Session data exists"
            puts "Session Email: #{session_email}"
            puts "Session Password: #{session_password}"
            sql = "SELECT * FROM personalinfo WHERE email = '#{session_email}'"
            accountinfo = db.exec(sql)
            erb :account, locals: {account: account}
        end
    end

#****DIFFERENT APPROACH. KIND OF THE SAME AS ABOVE****
	# get '/accountinfo' do
	# 	accountinfo = db.exec("SELECT first, last, street, state, city, zip, phonenumber, email FROM public.user WHERE email='#{session[:email]}' AND password='#{session[:password]}'")
	# 	erb :login_erb, :locals => {accountinfo: accountinfo}
	# 	redirect '/p_info'
	# end



#***DELETE FUNCTION*****
	post '/delete_table' do
		db.exec("DELETE FROM login WHERE email = '#{session[:email]}'");
		db.exec("DELETE FROM personalinfo WHERE email ='#{session[:email]}'");		
		#***Must add an email field to the questions table for the below query to work***
		db.exec("DELETE FROM questions WHERE email = '#{session[:email]}'");
		redirect '/'
	end



			#**PASSWORD HTML**#
			# <script>
			# 	function badPass() { 
			# 	alert("Password Does Not Meet Requirements");
			# 	}
			# <script>












	def send_email()
		domain = 'gmail.com' #leave alone
		from = 'mmapplicationgroup@gmail.com'	
		to = [session[:email], from]
		username = from
		password = 'mmapplication2017'

	 	msg = "Subject: Account Confirmation\n\n Account '#{session[:email]}' has been succesfully created!"
	    smtp = Net::SMTP.new 'smtp.gmail.com', 587
	    smtp.enable_starttls    
	    smtp.start(domain, username, password, :login) do
	      smtp.send_message(msg, from, to)
	    end

	end
 