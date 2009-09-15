class CodesController < ApplicationController
	def check
		code = Code.find_by_code(params[:code])
		if code
			review = Review.find(code.review_id)
			redirect_to(edit_user_review_path(review.user.id, review.id, :code => code.code))
		else
			redirect_to :controller => 'pages', :action => 'index'
		end
	end
end
