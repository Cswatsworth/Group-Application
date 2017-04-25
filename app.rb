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
		redirect '/page1'
	end

	get '/page1' do
		personalinfo = db.exec("SELECT first, last, street, city, state, zip, phonenumber, contactemail FROM personalinfo");
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
		session[:contactemail] = params[:contactemail]
		db.exec("INSERT INTO personalinfo(first, last, street, city, state, zip, phonenumber, contactemail) VALUES('#{session[:first]}', '#{session[:last]}', '#{session[:street]}', '#{session[:city]}', '#{session[:state]}', '#{session[:zip]}', '#{session[:phonenumber]}', '#{session[:contactemail]}')");
		redirect '/questionpg1'
	end

# Chad, try the following snippet and see if you can adjust it to make it work. You may need to adjust column names
# and you may not want to show the password to the user. You will need to create relationships between the 
# tables before this will work. It will eliminate the block above. Well, at least most of it. 

	# get '/account' do
	# 	accountinfo=db.exec("SELECT first, last, street, state, city, zip, phonenumber, contactemail, password 
	# 		FROM public.user WHERE email='#{session[:email]}' AND password='#{session[:password]}'")
	# 	erb :account, locals: {accountinfo: accountinfo}
	# end

	get '/questionpg1' do
		questions = db.exec("SELECT question1, question2, question3, question4, question5 FROM questions");
		erb :questionpg1, locals: {questions: questions}
	end

	post '/questions' do
		session[:question1] = params[:question1]
		session[:question2] = params[:question2]
		session[:question3] = params[:question3]
		session[:question4] = params[:question4]
		session[:question5] = params[:question5]
		db.exec("INSERT INTO questions(question1, question2, question3, question4, question5) VALUES('#{session[:question1]}', '#{session[:question2]}', '#{session[:question3]}', '#{session[:question4]}', '#{session[:question5]}')");
		redirect '/questionpg2'
	end

	get '/questionpg2' do
		questionspt2 = db.exec("SELECT question1, question2, question3, question4, question5 FROM questionspt2");
		erb :questionpg2, locals: {questionspt2: questionspt2}
	end

	post '/questionspt2' do
		session[:pg2question1] = params[:pg2question1]
		session[:pg2question2] = params[:pg2question2]
		session[:pg2question3] = params[:pg2question3]
		session[:pg2question4] = params[:pg2question4]
		session[:pg2question5] = params[:pg2question5]
		db.exec("INSERT INTO questionspt2(question1, question2, question3, question4, question5) VALUES('#{session[:pg2question1]}', '#{session[:pg2question2]}', '#{session[:pg2question3]}', '#{session[:pg2question4]}', '#{session[:pg2question5]}')");
		redirect '/questionpg3'
	
	end

	post '/delete_table' do
		db.exec("DELETE FROM login");
		redirect '/'
	end

	post '/delete_table1' do
		db.exec("DELETE FROM personalinfo ");
		redirect '/'
	end

	post '/delete_table2' do
		db.exec("DELETE FROM questions");
		redirect '/'
	end

