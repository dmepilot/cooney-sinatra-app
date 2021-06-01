class UsersController < ApplicationController

    get '/manager' do
        # binding.pry
        erb :'/users/login.html'
    end
    
    post '/manager' do
        user=User.find_by(:username => params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id]=user.id
            #  flash[:success]="Successfully signed in as #{user.username}."
            redirect to("/postings")

        else
            #  flash[:error]="Invalid Login" 
            redirect to("/login")
        end
    end

    get '/logout' do
        if logged_in?
          session.destroy
          redirect to '/'
        else
          redirect to '/'
        end
    end
end