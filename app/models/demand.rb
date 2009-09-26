class Demand < ActiveRecord::Base
	belongs_to :user
	
	validates_presence_of :email, :name, :work
	validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
	
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
