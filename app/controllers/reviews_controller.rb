class ReviewsController < ApplicationController

	def new
		@choices = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
		@demand = Demand.find(params[:demand_id])
		@review = Review.new
		@review.demand_id = @demand.id
		if !@demand || @demand.completed?
			redirect_to home_path
		end
	end
	
	def create
		@review = Review.new(params[:review])
		demand = Demand.find(@review.demand_id)
		@review.update_attributes(:name => demand.name, :company => demand.company, :email => demand.email, :user_id => demand.user_id, :work => demand.work)
		if @review.save
			demand.toggle! :completed
			demand.toggle! :code_used
			redirect_to user_path(@review.user)
		else
			render :action => 'new'
		end
	end
	
end
