class ReviewsController < ApplicationController

	def new
		@review = current_user.reviews.new
	end
	
	def create
		@review = current_user.reviews.new(params[:review])
		if @review.save
			code = Code.create!(:review_id => @review.id)
      Notifier.deliver_request(@review.name, @review.work, @review.email, code.code)
			redirect_to :controller => 'users', :action => 'show', :handle => current_user.handle
		else
			render :action => 'new'
		end
	end
	
	def edit
		@code = Code.find_by_code(params[:code])
		if @code && !@code.used?
			@code.toggle! :used
			@user = User.find(params[:user_id])
			@review = Review.find(params[:id])
			render :action => 'edit'
		else
			redirect_to :controller => 'pages', :action => 'index'
		end
	end
	
	def update
	  @review = Review.find(params[:id])
    if @review.update_attributes(params[:review])
      flash[:notice] = 'Your review has been submitted!'
      redirect_to :controller => 'pages', :action => 'index'
    else
      flash[:error] = 'There was a problem creating your review!'
      redirect_to :action => 'edit'
    end
	end
	
end
