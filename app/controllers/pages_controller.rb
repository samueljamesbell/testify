class PagesController < ApplicationController
	def index
		@email = Email.new
		render :layout => 'new'
	end
end
