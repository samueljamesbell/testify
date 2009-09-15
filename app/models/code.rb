class Code < ActiveRecord::Base
	before_create :process
	
	require 'digest/sha1'
	
	def process
	  self.code = Digest::SHA1.hexdigest([Time.now, rand].join)[0,5]
	  self.used = 0
	end
	
end
