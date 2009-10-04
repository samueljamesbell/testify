class UsersController < ApplicationController
	before_filter :authorise, :only => ['edit', 'update', 'destroy']

  def new
    @user = User.new
  end
  
  def show
	  @user = User.find_by_handle(params[:id])
	  @reviews = @user.limited_reviews
# 	reviews can = @user.reviews for paying users. below code sorts by total_rating
#	  @reviews = @user.reviews.sort { |x,y| y.total_rating <=> x.total_rating }[0..1]
	  unless @user
  	  flash[:error] = "An error has occurred. User could not be not found."
	  	redirect_to welcome_path
	  end
	rescue ActiveRecord::RecordNotFound
    logger.error("Attempt to show user with invalid id. #{params[:id]}" )
    flash[:error] = "An error has occurred. User could not be not found."
    redirect_to welcome_path
  end

  def edit
	  @user = User.find_by_handle(params[:id])
	  unless @user
  	  flash[:error] = "An error has occurred. User could not be not found."
	  	redirect_to welcome_path
	  end
	  redirect_to welcome_path unless @user == current_user
	rescue ActiveRecord::RecordNotFound
    logger.error("Attempt to edit user with invalid id. #{params[:id]}" )
    flash[:error] = "An error has occurred. User could not be not found."
    redirect_to welcome_path
  end

  def create
		code = Invite.find(:first, :conditions => { :code => params[:user][:beta_code] } )
		if code.nil? || code.used?
  		flash[:error] = 'Your invitation code is invalid.'
  		redirect_to :action => 'new'
  	else
    	@user = User.new(params[:user])
    	if @user.save
   			code.update_attribute :used, true
   	  	redirect_to user_path(@user, :first_time => 'true')
   	  	session[:user_id] = @user.id
   		else
   	  	render :action => 'new'
   		end
   	end
  end

  def update
    @user = User.find_by_handle(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = 'Your account details have been updated.'
      redirect_to user_path(@user)
    else
      flash[:error] = 'There was a problem updating your details.'
      redirect_to :action => 'edit'
    end
	rescue ActiveRecord::RecordNotFound
    logger.error("Attempt to update user with invalid id. #{params[:id]}" )
    flash[:error] = "An error has occurred. User could not be not found."
    redirect_to welcome_path
  end

  def destroy
    @user = User.find(params[:id])
    if @user == current_user
    	@user.destroy
			flash[:notice] = 'Account terminated.'
    	redirect_to :controller => 'pages', :action => 'index'
    else
    	flash[:error] = 'You don\'t have permission to do that!'
    	redirect_to :controller => 'pages', :action => 'index'
    end
	rescue ActiveRecord::RecordNotFound
    logger.error("Attempt to destroy user with invalid id. #{params[:id]}" )
    flash[:error] = "An error has occurred. User could not be not found."
    redirect_to welcome_path
  end
  
end
