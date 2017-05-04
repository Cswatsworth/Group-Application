require 'sinatra'
require 'pg'
require_relative 'functions.rb'
require 'net/smtp'
#require 'bcrypt'


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
        session[:email] = nil
        session[:password] = nil
        session[:first] = nil
        session[:last] = nil
        session[:street] = nil
        session[:city] = nil
        session[:state] = nil
        session[:zip] = nil
        session[:phonenumber] = nil
        session[:linkedin] = nil
        session[:twitter] = nil
        session[:facebook] = nil
        session[:github] = nil
        session[:other] = nil
        session[:question1] = nil
        session[:question2] = nil
        session[:question3] = nil
        session[:question4] = nil
        session[:question5] = nil
        session[:question6] = nil
        session[:question7] = nil
        session[:question8] = nil
        session[:question9] = nil
        session[:question10] = nil
        session[:question11] = nil
        session[:question12] = nil
        session[:question13] = nil
        session[:question14] = nil
        session[:question15] = nil
        session[:question16] = nil
        session[:question17] = nil
        session[:question18] = nil
        session[:question19] = nil
        session[:question20] = nil

        login = db.exec("SELECT email FROM personalinfo");
        erb :login#, locals: {login: login}
    end

    post '/login' do
        session[:email] = nil
        login = db.exec("SELECT email, password FROM personalinfo");
        erb :login
    end

    get '/login' do
        session[:message] = nil
        erb :login, locals: {message: ''}
    end

    get '/invalid_login' do 
        message = 'You have entered an incorrect email or password.'
        erb :login, locals: {message: message}
    end

    post '/check_login' do
        session[:email] = params[:email]
        if login_match?(session[:email], params[:password])
            redirect '/account'
        else
            redirect '/invalid_login'
        end
    end

    post '/create_account' do
        redirect '/create_account'
    end

    get '/create_account' do
        message1 = nil
        message2 = nil
        erb :create_account, locals: {message1: message1, message2: message2}
    end

    post'/p_info' do #was post to login
        session[:email] = params[:email]
        session[:password] = params[:password]

        first = ""
        last = ""
        street = ""
        city = ""
        state = ""
        zip = ""
        phonenumber = ""
        linkedin = ""
        twitter = ""
        facebook = ""
        github = ""
        other = ""
        question1 = ""
        question2 = ""
        question3 = ""
        question4 = ""
        question5 = ""
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
        db.exec("INSERT INTO personalinfo(email,password, first, last, street, city, state, zip, phonenumber, linkedin, twitter, facebook, github, other, question1,question2,question3,question4,question5,question6,question7,question8,question9,question10,question11,question12,question13,question14,question15,question16,question17,question18,question19,question20) VALUES('#{session[:email]}','#{session[:password]}', '#{first}', '#{last}', '#{street}', '#{city}', '#{state}', '#{zip}', '#{phonenumber}', '#{linkedin}', '#{twitter}', '#{facebook}', '#{github}', '#{other}', '#{question1}', '#{question2}', '#{question3}', '#{question4}', '#{question5}','#{question6}', '#{question7}', '#{question8}', '#{question9}', '#{question10}', '#{question11}', '#{question12}', '#{question13}', '#{question14}', '#{question15}', '#{question16}', '#{question17}', '#{question18}', '#{question19}', '#{question20}')");
        redirect '/p_info'
        #end
    end

    get '/p_info' do
        personalinfo = db.exec("SELECT first, last, street, city, state, zip, phonenumber, email, linkedin, twitter, github, other FROM personalinfo");
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
        session[:linkedin] = params[:linkedin]
        session[:twitter] = params[:twitter]
        session[:facebook] = params[:facebook]
        session[:github] = params[:github]
        session[:other] = params[:other]

        db.exec("UPDATE personalinfo SET first='#{session[:first]}', last='#{session[:last]}', street='#{session[:street]}', city='#{session[:city]}', state='#{session[:state]}', zip='#{session[:zip]}', phonenumber='#{session[:phonenumber]}', linkedin='#{session[:linkedin]}', twitter='#{session[:twitter]}', facebook='#{session[:facebook]}', github='#{session[:github]}', other='#{session[:other]}' WHERE email='#{session[:email]}'");
        redirect '/questionpg1'
    end

    get '/questionpg1' do
        questions = db.exec("SELECT question1, question2, question3, question4, question5, email FROM personalinfo");
        erb :questionpg1, locals: {questions: questions}
    end

    post '/questions' do
        session[:question1] = params[:question1]
        session[:question2] = params[:question2]
        session[:question3] = params[:question3]
        session[:question4] = params[:question4]
        session[:question5] = params[:question5]

        db.exec("UPDATE personalinfo SET question1='#{session[:question1]}', question2='#{session[:question2]}', question3='#{session[:question3]}', question4='#{session[:question4]}', question5='#{session[:question5]}' WHERE email='#{session[:email]}'");

        redirect '/questionpg2'
    end

    get '/questionpg2' do
        questions = db.exec("SELECT question6, question7, question8, question9, question10, email FROM personalinfo");
        erb :questionpg2, locals: {questions: questions}
    end

    post '/questions1' do
        session[:question6] = params[:question6]
        session[:question7] = params[:question7]
        session[:question8] = params[:question8]
        session[:question9] = params[:question9]
        session[:question10] = params[:question10]

        db.exec("UPDATE personalinfo SET question6='#{session[:question6]}', question7='#{session[:question7]}', question8='#{session[:question8]}', question9='#{session[:question9]}', question10='#{session[:question10]}' WHERE email='#{session[:email]}'");

        redirect '/questionpg3'

    end

    get '/questionpg3' do
        questions = db.exec("SELECT question11, question12, question13, question14, question15, email FROM personalinfo");
        erb :questionpg3, locals: {questions: questions}
    end

    post '/questions2' do
        session[:question11] = params[:question11]
        session[:question12] = params[:question12]
        session[:question13] = params[:question13]
        session[:question14] = params[:question14]
        session[:question15] = params[:question15]


        db.exec("UPDATE personalinfo SET question11='#{session[:question11]}', question12='#{session[:question12]}', question13='#{session[:question13]}', question14='#{session[:question14]}', question15='#{session[:question15]}' WHERE email='#{session[:email]}'");

        if
            p "Please Answer Atleast One!"
        end

        redirect '/review'
    end


##**FOR QUESTIONS 16-20 ^^WILL NEED TO CHANGE REDIRECT TO QUESTIONPG4**##
    
    # get '/questionpg4' do
    #     questions = db.exec("SELECT question16, question17, question18, question18, question20, email FROM personalinfo");
    #     erb :questionpg4, locals: {questions: questions}
    # end

    # post '/questions3' do
    #     session[:question16] = params[:question16]
    #     session[:question17] = params[:question17]
    #     session[:question18] = params[:question18]
    #     session[:question19] = params[:question19]
    #     session[:question20] = params[:question20]

    #     db.exec("UPDATE personalinfo SET question16='#{session[:question16]}', question17='#{session[:question17]}', question18='#{session[:question18]}', question19='#{session[:question19]}', question20='#{session[:question20]}' WHERE email='#{session[:email]}'");
    #     redirect '/review'
    # end

    get '/review' do
                session_email = session[:email]
#        account_info = db.exec("SELECT * FROM public.personalinfo WHERE email='#{session[:email]}'")||''
        signin = db.exec("SELECT * FROM personalinfo WHERE email='#{session[:email]}' AND password='#{session[:password]}'");
        sql = "SELECT * FROM personalinfo WHERE email = '#{session[:email]}'"
            accountinfo = db.exec(sql)
        erb :review, locals: {accountinfo: accountinfo}
       
    end


    post '/send_email' do

        send_email
        #Might need to tweak this to redirect to desired page or create an email successfully sent page
        #have to change email settings to 'less secure apps'
        redirect '/complete'
    end

    get '/complete' do
        erb :complete

    end

    post '/check_login' do
        session[:email] = params[:email]
        if login_match?(session[:email], params[:password])
            redirect '/account'
        else
            redirect '/invalid_login'
        end
    end

    get '/invalid_login' do
        session[:message] = 'The username or password you entered is incorrect.'
        erb :login, locals: {message: message}  
    end




    get '/account' do
        session_email = session[:email]
#        account_info = db.exec("SELECT * FROM public.personalinfo WHERE email='#{session[:email]}'")||''
         signin = db.exec("SELECT * FROM personalinfo WHERE email='#{session[:email]}' AND password='#{session[:password]}'");
        sql = "SELECT * FROM personalinfo WHERE email = '#{session[:email]}'"
            accountinfo = db.exec(sql)
        erb :account, locals: {accountinfo: accountinfo}
    end



#        post '/account' do
#         session_email = session[:email]
#         session_password = session[:password]
#         if (session_email == nil || session_password == nil)
#             email = params[:email]
#             password = params[:password]
#             sql = "SELECT email FROM personalinfo WHERE email = '#{session[:email]}' AND password = '#{password}'"
#             puts "Email: #{session[:email]}"
#             puts "Password: #{password}"
#             puts sql
#             account = db.exec(sql)||''
#             if account.num_tuples == 0
#                 puts "get out of here"
#                 redirect '/account'
#             else
#                 puts "Sweet baby jesus"

#                # hashed_password = BCrypt::Password.create("#{password}")

#                 session[:email] = params[:email]
#                 session[:password] = params[:password]
#                 sql = "SELECT * FROM personalinfo WHERE email = '#{session_email}'"
#                 accountinfo = db.exec(sql)
# #                erb :account, locals: {account: account,account_info: account_info}
#                 redirect '/account'
#             end
#         else
#             puts "Session data exists"
#             puts "Session Email: #{session_email}"
#             puts "Session Password: #{session_password}"
#             sql = "SELECT * FROM personalinfo WHERE email = '#{session_email}'"
#             accountinfo = db.exec(sql)

#               redirect '/account'
#         end
#     end

    #****FACEBOOK LOGIN****#

    get '/facebook' do
        session[:first] = params[:first_name]
        session[:last] = params[:last_name]
        session[:id] = params[:id]

        if fb_user_exist?(params[:fb_id]) == false
            erb :login, locals: {first: session[:first], last: session[:last]}
            else
            dbname = db.exec("SELECT email, id FROM personalinfo")
             dbname.each do |item|
                if item['id'] == params[:id]
                    session[:email] = item['email']
                end
        end
        redirect '/personalinfo'
    end
end


#***DELETE FUNCTION*****
    post '/delete_table' do
        db.exec("DELETE FROM personalinfo WHERE email = '#{session[:email]}'");
        db.exec("DELETE FROM personalinfo WHERE email ='#{session[:email]}'");
        #***Must add an email field to the questions table for the below query to work***
        db.exec("DELETE FROM personalinfo WHERE email = '#{session[:email]}'");
        redirect '/'
    end



            #**PASSWORD HTML**#
            # <script>
            #     function badPass() {
            #     alert("Password Does Not Meet Requirements");
            #     }
            # <script>







##**FUNCTIONS**##




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
