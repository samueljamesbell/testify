xml.user(:id => @user.id) do
	xml.name(@user.name)
	xml.email(@user.email)
	xml.username(@user.handle)
	xml.image_url("http://testifyapp.com#{@user.logo.url(:small)}")
	xml.about(@user.about)
	xml.site(@user.site)
	
	xml.reviews do
		@reviews.each do |review|
			xml.review(:id => review.id) do
				unless review.name_hidden?
					xml.name(review.name)
				end
				unless review.company_hidden?
					xml.company(review.company)
				end
				xml.project(review.work)
				xml.reviewer_email(review.email)
				xml.body(review.body)
				xml.created_at(review.created_at)
				xml.updated_at(review.updated_at)
			end
		end
	end
	
end
