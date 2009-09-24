class DemandsController < ApplicationController
	before_filter :authorise, :except => :show

	def index
	  @user = current_user
		@demands = current_user.demands.find(:all, :conditions => { :completed => false })
	end
	
	def show
		demand = Demand.find_by_code(params[:code])
		if demand && !demand.code_used? && !logged_in?
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
			if @demand.send_email.to_i == 1
				flash[:success] = 'Request for review successful.'
      	Notifier.deliver_demand(@demand.name, @demand.work, @demand.email, @demand.code)
      end
		else
			render :action => 'new'
		end
	end
	
	def send_email
		@demand = Demand.find(params[:id])
	 	Notifier.deliver_reminder(@demand.name, @demand.work, @demand.email, @demand.code)
	 	respond_to do |format|
	 		format.js
	 	end
	rescue ActiveRecord::RecordNotFound
    logger.error("Attempt to send_email to pending demand with invalid id. #{params[:id]}" )
    flash[:error] = "An error has occurred: Demand not found."
    redirect_to welcome_path
	end
	
end
