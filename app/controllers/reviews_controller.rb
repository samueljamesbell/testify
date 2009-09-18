class ReviewsController < ApplicationController

	def new
		@demand = Demand.find(params[:demand_id])
		@review = Review.new
		@review.demand_id = @demand.id
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
