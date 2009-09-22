class ReviewsController < ApplicationController

	def new
		@choices = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
		@demand = Demand.find(params[:demand_id])
		@review = Review.new
		@review.demand_id = @demand.id
		if !@demand || @demand.completed?
			redirect_to home_path
		end
	rescue ActiveRecord::RecordNotFound
    logger.error("Attempt to create new review with invalid demand id. #{params[:demand_id]}" )
    flash[:error] = "An error has occurred. Demand not found."
    redirect_to welcome_path
	end
	
	def create
		@choices = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
		@review = Review.new(params[:review])
		@demand = Demand.find(@review.demand_id)
		@review.update_attributes(:name => @demand.name, :company => @demand.company, :email => @demand.email, :user_id => @demand.user_id, :work => @demand.work)
		if @review.save
			@demand.toggle! :completed
			@demand.toggle! :code_used
			Notifier.deliver_review_completed(@review.name, @review.work, @demand.user.email, @review.user.handle)
			flash[:success] = 'Your review was created and saved successfully.'
			redirect_to user_path(@review.user)
		else
			render :action => 'new'
		end
	end
	
	def hide_name
		@review = Review.find_by_id(params[:id])
		@review.update_attribute :name_hidden, true
		respond_to do |format|
			format.js
		end
	rescue ActiveRecord::RecordNotFound
    logger.error("Attempt to hide_name of review with invalid id. #{params[:id]}" )
    flash[:error] = "An error has occurred. Review not found."
    redirect_to welcome_path
	end
	
	def unhide_name
		@review = Review.find_by_id(params[:id])
		@review.update_attribute :name_hidden, false
		respond_to do |format|
			format.js
		end
	rescue ActiveRecord::RecordNotFound
    logger.error("Attempt to unhide_name of review with invalid id. #{params[:id]}" )
    flash[:error] = "An error has occurred. Review not found."
    redirect_to welcome_path
	end
	
	def hide_company
		@review = Review.find_by_id(params[:id])
		@review.update_attribute :company_hidden, true
		respond_to do |format|
			format.js
		end
	rescue ActiveRecord::RecordNotFound
    logger.error("Attempt to hide_company of review with invalid id. #{params[:id]}" )
    flash[:error] = "An error has occurred. Review not found."
    redirect_to welcome_path
	end
	
	def unhide_company
		@review = Review.find_by_id(params[:id])
		@review.update_attribute :company_hidden, false
		respond_to do |format|
			format.js
		end
	rescue ActiveRecord::RecordNotFound
    logger.error("Attempt to unhide_company of review with invalid id. #{params[:id]}" )
    flash[:error] = "An error has occurred. Review not found."
    redirect_to welcome_path
	end
	
end
