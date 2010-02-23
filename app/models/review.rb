class Review < ActiveRecord::Base
	belongs_to :user
	
	def ratings_options
		@ratings_options = ['awful', 'poor', 'average', 'good', 'excellent']
	end
	
	def total_rating
		@total_rating	= customer_service + time_management + value_for_money + quality_of_service
	end
	
	validates_presence_of :name, :email, :body
	
	validates_numericality_of [:value_for_money, :time_management, :customer_service, :quality_of_service]
	validates_inclusion_of [:value_for_money, :time_management, :customer_service, :quality_of_service], :in => 0..4
	
	
end
