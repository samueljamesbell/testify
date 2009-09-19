class Demand < ActiveRecord::Base
	belongs_to :user
	
  before_create :process
	
	require 'digest/sha1'
	
	validates_presence_of :name, :company, :emaill, :work
	
	def process
	  self.code = Digest::SHA1.hexdigest([Time.now, rand].join)[0,5]
	  self.code_used = 0
	  self.completed = 0
	end
	
end
