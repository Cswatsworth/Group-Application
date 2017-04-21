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
		redirect '/'
	end

	# post '/signup' do
	# 	erb :page1
	# end
	# 	session[:backend_1st_name] = params[:first]
	# 	session[:backend_lst_name] = params[:last]
	# 	session[:backend_street] = params[:street]
	# 	session[:backend_city] = params[:city]
	# 	session[:backend_state] = params[:state]
	# 	session[:backend_zip] = params[:zip]
	# 	erb :page1, :locals => {first: session[:backend_1st_name], last: session[:backend_lst_name], street: session[:backend_street], city: session[:backend_city], state: session[:backend_state], zip: session[:backend_zip]}
	# end

	# get '/signin' do
	#  	erb :signin
	# end