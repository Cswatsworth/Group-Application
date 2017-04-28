require 'sinatra'
require 'pg'
require_relative 'functions.rb'

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


	get '/' do
		login = db.exec("SELECT email, password FROM login");
		erb :index, locals: {login: login}
	end

	get '/signin' do
		signin = db.exec("SELECT first, last, street, state, city, zip, phonenumber, email FROM public.personalinfo WHERE email='#{session[:email]}' AND password='#{session[:password]}'")
		erb :index, locals: {personalinfo: personalinfo}
		redirect '/page1'
	end


	post'/login' do
		session[:email] = params[:email]
		session[:password] = params[:password]
		db.exec("INSERT INTO login(email, password) VALUES('#{session[:email]}', '#{session[:password]}')");
		first = ""
		last = ""
		street = ""
		city = ""
		state = ""
		zip = ""
		phonenumber = ""
		db.exec("INSERT INTO personalinfo(email, password, first, last, street, city, state, zip, phonenumber) VALUES('#{session[:email]}', '#{session[:password]}', '#{first}', '#{last}', '#{street}', '#{city}', '#{state}', '#{zip}', '#{phonenumber}')");
		redirect '/page1'
	end

	get '/page1' do
		personalinfo = db.exec("SELECT first, last, street, city, state, zip, phonenumber, email FROM personalinfo");
		erb :page1, locals: {personalinfo: personalinfo}
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
		redirect '/complete'
	end

	get '/complete' do
		erb :complete
	end

	# post '/delete_table' do
	# 	db.exec("DELETE FROM login");
	# 	redirect '/'
	# end

	# post '/delete_table1' do
	# 	db.exec("DELETE FROM personalinfo ");
	# 	redirect '/'
	# end

	# post '/delete_table2' do
	# 	db.exec("DELETE FROM questions");
	# 	redirect '/'
	# end
