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
		redirect '/questions'
	end
