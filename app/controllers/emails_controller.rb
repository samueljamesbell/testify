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
			flash[:success] = "We've got your email! Thanks for your interest, we'll contact you as soon as we can."
			redirect_to welcome_path
		else
			render :action => 'new'
		end
	end
	
end
