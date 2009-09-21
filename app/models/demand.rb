class Demand < ActiveRecord::Base
	belongs_to :user
	
  before_create :process
  
  attr_accessor :send_email, :boolean
	
	require 'digest/sha1'
	
	validates_presence_of :name, :company, :email, :work
	
	def process
	  self.code = Digest::SHA1.hexdigest([Time.now, rand].join)[0,5]
	  self.code_used = 0
	  self.completed = 0
	end
	
end
