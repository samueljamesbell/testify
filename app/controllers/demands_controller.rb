class DemandsController < ApplicationController
	before_filter :authorise

	def index
	end
	
	def show
		demand = Demand.find_by_code(params[:code])
		if demand && !demand.code_used?
			redirect_to(new_user_review_path(demand.user, :demand_id => demand.id))
		else
			redirect_to :controller => 'pages', :action => 'index'
		end
	end
	
	def new
		@demand = current_user.demands.new
	end
	
	def create
		@demand = current_user.demands.build(params[:demand])
		if @demand.save
      Notifier.deliver_demand(@demand.name, @demand.work, @demand.email, @demand.code)
			redirect_to user_path(current_user)
		else
			render :action => 'new'
		end
	end
	
end
