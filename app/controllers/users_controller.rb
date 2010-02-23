class UsersController < ApplicationController
	before_filter :authorise, :only => ['edit', 'update', 'destroy']

  def new
    @user = User.new
  end
  
  def show
	  @user = User.find_by_handle(params[:user_id])
	  if @user
			@reviews = @user.limited_reviews
# 		reviews can = @user.reviews for paying users. below code sorts by total_rating
# 		@reviews = @user.reviews.sort { |x,y| y.total_rating <=> x.total_rating }[0..1]
		else
  	  flash[:error] = "An error has occurred. User could not be not found."
  	  respond_to do |format|
  	  	format.html { redirect_to welcome_path }
  	  	format.xml { render :layout => :false }
  	  end
	  	
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
	rescue ActiveRecord::RecordNotFound
    logger.error("Attempt to edit user with invalid id. #{params[:id]}" )
    flash[:error] = "An error has occurred. User could not be not found."
    redirect_to welcome_path
  end

  def create
		if params[:user][:beta_code] == 'enterprise'
			@user = User.new(params[:user])
    	if @user.save
   		 	redirect_to :controller => 'users', :action => 'edit', :id => @user.handle, :first_time => 'true'
   		 	session[:user_id] = @user.id
   		else
   		 	render :action => 'new'
   		end
		else
			code = Invite.find(:first, :conditions => { :code => params[:user][:beta_code] } )
			if code.nil? || code.used?
  			flash[:error] = 'Your invitation code is invalid.'
  			redirect_to :action => 'new'
  		else
    		@user = User.new(params[:user])
    		if @user.save
   				code.update_attribute :used, true
   		  	redirect_to :controller => 'users', :action => 'edit', :id => @user.handle, :first_time => 'true'
   		  	session[:user_id] = @user.id
   			else
   		  	render :action => 'new'
   			end
   		end
  	end
  end
 
  def update
    @user = User.find_by_handle(params[:id])
    if @user.update_attributes(params[:user])
      if params[:first_time] == 'true'
      	redirect_to :controller => 'users', :action => 'edit', :id => @user.handle, :upload_logo => 'true'
      elsif params[:upload_logo] == 'true'
        redirect_to :controller => 'users', :action => 'edit', :id => @user.handle, :criteria => 'true'
      else
     		flash[:success] = 'Your account details have been updated.'
      	redirect_to short_user_path(@user)
      end
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
    	redirect_to welcome_path
    else
    	flash[:error] = 'You don\'t have permission to do that!'
    	redirect_to welcome_path
    end
	rescue ActiveRecord::RecordNotFound
    logger.error("Attempt to destroy user with invalid id. #{params[:id]}" )
    flash[:error] = "An error has occurred. User could not be not found."
    redirect_to welcome_path
  end
  
end
