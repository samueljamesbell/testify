class Demand < ActiveRecord::Base
	belongs_to :user
	
  before_create :process
	
	require 'digest/sha1'
	
	def process
	  self.code = Digest::SHA1.hexdigest([Time.now, rand].join)[0,5]
	  self.code_used = 0
	end
	
end
