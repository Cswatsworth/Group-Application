require 'sinatra'
# require_relative 'functions.rb'

	enable :sessions

	get '/' do
		session[:backend_email] = params[:email]
		session[:backend_password] = params[:password]
		erb :index
	end

	get '/signup' do
		erb :welcome
	end

	get '/signin' do
	 	erb :continue
	end