class UsersController < ApplicationController

    get '/manager' do
        # binding.pry
        erb :'/users/login.html'
    end
    
    post '/manager' do
        @user=User.find_by(:username => params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id]=@user.id
            flash[:success]="Successfully signed in as #{user.username}."
            redirect to("/postings")

        else
            flash[:error]=" Invalid Login. Please try again." 
            redirect to("/manager")
        end
    end

    get '/users/new' do
        erb :'/users/new.html'
    end

    post '/users/new' do
        unless User.find_by(:username => params[:username]) 
          user=User.new(:username => params[:username], :password => params[:password])
          if user.save 
            session[:user_id]=user.id
            flash[:success]="Successfully signed in as #{user.username}."
            redirect to("/postings")
          else
            flash[:incomplete]="Please fill in all fields" 
            redirect to "/signup"
         end
        else
          flash[:taken]="Username already in use" 
          redirect to "/users/new"
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
        flash[:updated]="Profile successfully updated."
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