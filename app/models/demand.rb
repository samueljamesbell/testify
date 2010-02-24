class Demand < ActiveRecord::Base
	belongs_to :user
	
	require 'digest/sha1'
	
	validates_presence_of :email, :name
	validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
	
  before_create :process
  
  attr_accessor :send_email, :boolean
	
	def process
	  self.code = Digest::SHA1.hexdigest([Time.now, rand].join)[0,5]
	  self.code_used = 0
	  self.completed = 0
	end
	
end
