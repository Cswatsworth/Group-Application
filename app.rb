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


	post'/login' do
		session[:email] = params[:email]
		session[:password] = params[:password]
		db.exec("INSERT INTO login(email, password) VALUES('#{session[:email]}', '#{session[:password]}')");
		db.exec("INSERT INTO personalinfo(email, password) VALUES('#{session[:email]}', '#{session[:password]}')");
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
		session[:email] = params[:email]
		db.exec("INSERT INTO personalinfo(first, last, street, city, state, zip, phonenumber, email) VALUES('#{session[:first]}', '#{session[:last]}', '#{session[:street]}', '#{session[:city]}', '#{session[:state]}', '#{session[:zip]}', '#{session[:phonenumber]}', '#{session[:email]}')");
		# db.exec("INSERT INTO questions(email) VALUES('#{session[:email]}')");
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
		session[:email] = params[:email]
		db.exec("INSERT INTO questions(question1, question2, question3, question4, question5, email) VALUES('#{session[:question1]}', '#{session[:question2]}', '#{session[:question3]}', '#{session[:question4]}', '#{session[:question5]}', '#{session[:email]}')");
		# db.exec("INSERT INTO questions(email) VALUES('#{session[:email]}')");
		redirect '/questionpg2'
	end

	get '/questionpg2' do
		questions = db.exec("SELECT question6, question7, question8, question9, question10, email FROM questions");
		erb :questionpg2, locals: {questions: questions}
	end

	post '/questions' do
		session[:question6] = params[:question6]
		session[:question7] = params[:question7]
		session[:question8] = params[:question8]
		session[:question9] = params[:question9]
		session[:question10] = params[:questio10]
		session[:email] = params[:email]
		db.exec("INSERT INTO questions(question6, question7, question8, question9, question10, email) VALUES('#{session[:question6]}', '#{session[:question7]}', '#{session[:question8]}', '#{session[:question9]}', '#{session[:question10]}', '#{session[:email]}')");
		redirect '/questionpg3'
	
	end

	get '/questionpg3' do
		questions = db.exec("SELECT question11, question12, question13, question14, question15, email FROM questions");
		erb :questionpg3, locals: {questions: questions}
	end

	post '/questions' do
		session[:question11] = params[:question11]
		session[:question12] = params[:question12]
		session[:question13] = params[:question13]
		session[:question14] = params[:question14]
		session[:question15] = params[:question15]
		session[:email] = params[:email]
		db.exec("INSERT INTO questions(question11, question12, question13, question14, question15, email) VALUES('#{session[:question11]}', '#{session[:question12]}', '#{session[:question13]}', '#{session[:question14]}', '#{session[:question15]}', '#{session[:email]}')");
		redirect '/questionpg4'
	end

	get '/questionpg4' do
		questions = db.exec("SELECT question16, question17, question18, question18, question20, email FROM questions");
		erb :questionpg3, locals: {questions: questions}
	end

	post '/questions' do
		session[:question16] = params[:question16]
		session[:question17] = params[:question17]
		session[:question18] = params[:question18]
		session[:question19] = params[:question19]
		session[:question20] = params[:question20]
		session[:email] = params[:email]
		db.exec("INSERT INTO questions(question16, question17, question18, question19, question20, email) VALUES('#{session[:question16]}', '#{session[:question17]}', '#{session[:question18]}', '#{session[:question19]}', '#{session[:question20]}', '#{session[:email]}')");
		redirect '/complete'
	end

	get '/complete' do
		erb :complete
	end



	# get '/accountinfo' do
	# 	accountinfo = db.exec("SELECT first, last, street, state, city, zip, phonenumber, email FROM public.user WHERE email='#{session[:email]}' AND password='#{session[:password]}'")
	# 	erb :index, locals: {accountinfo: accountinfo}
	# 	redirect '/page1'
	# end

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
