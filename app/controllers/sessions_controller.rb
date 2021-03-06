class SessionsController < ApplicationController
  before_filter :authorise, :except => :login

  def login
    if request.post?
      user = User.authenticate(params[:email], params[:password])
      if user
        session[:user_id] = user.id
        uri = session[:original_uri]
        session[:original_uri] = nil
        flash[:success] = "Successfully logged in."                                                           
        redirect_to short_user_path(user)
      else
        flash.now[:error] = "It looks like that wasn't quite right. Fancy another go?"
      end
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "Logged out."
    redirect_to welcome_path
  end

end
