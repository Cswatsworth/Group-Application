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
		# session[:backend_email] = params[:email]
		# session[:backend_password] = params[:password]
		mmapplication = db.exec("SELECT email, password FROM mmapplication");
		erb :index, locals: {mmapplication: mmapplication}
	end

	# post'/signup' do
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