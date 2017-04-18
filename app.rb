require 'sinatra'
# require_relative 'functions.rb'

	enable :sessions

	get '/' do
		session[:email] = params[:email]
		session[:password] = params[:password]
		erb :index
	end

