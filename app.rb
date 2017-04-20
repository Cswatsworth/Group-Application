require 'sinatra'
# require_relative 'functions.rb'

	enable :sessions

	get '/' do
		session[:backend_email] = params[:email]
		session[:backend_password] = params[:password]
		erb :index
	end

	post'/signup' do
		session[:backend_1st_name] = params[:first]
		session[:backend_lst_name] = params[:last]
		session[:backend_street] = params[:street]
		session[:backend_city] = params[:city]
		session[:backend_state] = params[:state]
		session[:backend_zip] = params[:zip]
		erb :page1, :locals => {first: session[:backend_1st_name], last: session[:backend_lst_name], street: session[:backend_street], city: session[:backend_city], state: session[:backend_state], zip: session[:backend_zip]}
	end

	get '/signin' do
	 	erb :signin
	end