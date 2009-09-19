class Review < ActiveRecord::Base
	belongs_to :user
	
	validates_presence_of :name, :company, :emaill, :work, :review, :value_for_money, :time_management, :customer_service, :quality_of_service
	
	validates_numericality_of [:value_for_money, :time_management, :customer_service, :quality_of_service]
	validates_inclusion_of [:value_for_money, :time_management, :customer_service, :quality_of_service], :in => 1..10
	
	
end
