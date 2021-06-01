class UsersController < ApplicationController

    get '/manager' do
        # binding.pry
        erb :'/users/login.html'
    end
    
    post '/manager' do
        user=User.find_by(:username => params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id]=user.id
            flash[:success]="Successfully signed in as #{user.username}."
            redirect to("/postings")

        else
            flash[:error]=" Invalid Login. Please try again." 
            redirect to("/manager")
        end
    end

    get '/users/:slug/edit' do
        @user=User.find_by_slug(params[:slug])
        erb :'/users/edit.html'
    end

    patch '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        @user.update(params[:user])
        @user.save
        redirect("/postings")
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