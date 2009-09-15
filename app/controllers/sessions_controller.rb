class SessionsController < ApplicationController
  before_filter :authorise, :except => :login

  def login
    if request.post?
      user = User.authenticate(params[:email], params[:password])
      if user
        session[:user_id] = user.id
        uri = session[:original_uri]
        session[:original_uri] = nil
        flash.now[:notice] = "Successfully logged in."                                                           
        redirect_to :controller => 'users', :action => 'show', :handle => @user.handle
      else
        flash.now[:error] = "Invalid user/password combination. Try again."
      end
    end
  end

  def logout
    session[:user_id] = nil
    flash.now[:notice] = "Logged out"
    redirect_to :controller => 'pages', :action => 'index'
  end

end
