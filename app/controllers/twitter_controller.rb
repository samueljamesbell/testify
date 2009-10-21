class TwitterController < ApplicationController
	def status_update
		@user = User.find_by_handle(params[:user_id])
		@review = Review.find(params[:review_id])
		status = "Just got reviewed on Testify: http://testifyapp.com/#{@user.handle}/#{@review.id}"
		httpauth = Twitter::HTTPAuth.new(@user.tusername, @user.tpassword)
		client = Twitter::Base.new(httpauth)
		client.update(status)
	 	respond_to do |format|
	 		format.js
	 	end
	end
end
