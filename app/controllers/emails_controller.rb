class EmailsController < ApplicationController
	
	def index
		@emails = Email.find(:all)
	end
	
	def new
		@email = Email.new
	end
	
	def create
		@email = Email.new(params[:email])
		if @email.save
			flash.now[:success] = "Thanks for your interest, we'll contact you as soon as we can."
			redirect_to welcome_path
		else
			flash.now[:error] = "Your email address appears to be invalid."
			render :action => 'new'
		end
	end
	
end
