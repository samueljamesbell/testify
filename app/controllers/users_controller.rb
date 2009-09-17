class UsersController < ApplicationController
	before_filter :authorise, :only => ['edit', 'update', 'destroy']

  def new
    @user = User.new
  end
  
  def show
	  @user = User.find_by_handle(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = 'Your account has been created. Thanks for signing up!'
      redirect_to user_path(@user)
      session[:user_id] = @user.id
    else
      flash[:error] = 'There was a problem creating your account.'
      redirect_to :action => 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = 'Your account details have been updated.'
      redirect_to :controller => 'pages', :action => 'index'
    else
      flash[:error] = 'There was a problem updating your details.'
      redirect_to :action => 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user == current_user
    	@user.destroy
    	redirect_to :controller => 'pages', :action => 'index'
    else
    	redirect_to :controller => 'pages', :action => 'index'
    end
  end
  
end
