class PostingsController < ApplicationController

  # GET: /postings
  get "/postings" do
    if logged_in?
      @postings = Posting.all
      erb :"/postings/index.html"
    else
      redirect "/"
    end
  end

  # GET: /postings/new
  get "/postings/new" do
    redirect "/"
  end

  # POST: /postings
  post "/postings/new" do
    new_posting=Posting.new(params[:posting])
    if new_posting.save
      # @postings = Posting.all
      # erb :'/postings/index.html'
      redirect "/postings"
    else
      # flash[:incomplete]="Please fill in all fields" 
      redirect '/postings/new'
    end
    redirect "/postings"
  end

  # GET: /postings/5
  get "/postings/:id" do
    @posting = Posting.find_by_id(params[:id])
    erb :"/postings/show.html"
  end

  # GET: /postings/5/edit
  get "/postings/:id/edit" do
    if logged_in?
      @posting = Posting.find_by_id(params[:id])
      erb :"/postings/edit.html"      
    else
      redirect to '/'
    end
  end

  # PATCH: /postings/5
  patch "/postings/:id" do
    @posting = Posting.find_by_id(params[:id])
    @posting.update(params[:posting])
    redirect "/postings"
  end

  # DELETE: /postings/5/delete
  delete "/postings/:id/delete" do
    posting = Posting.find_by_id(params[:id])
    posting.destroy
    redirect "/postings"
  end
end
