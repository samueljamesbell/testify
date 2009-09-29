class Invite < ActiveRecord::Base
	before_create :process
	
	require 'digest/sha1'
	
	def process
	  code = Digest::SHA1.hexdigest([Time.now, rand].join)[0,5]
	 	invite = Invite.find(:first, :conditions => { :code => code } )
	 	if invite
			while invite.exists?
				code = Digest::SHA1.hexdigest([Time.now, rand].join)[0,5]
	 			invite = Invite.find(:first, :conditions => { :code => code } )
	 		end
	  end
	  self.code = code
	  self.used = 0
	end
end
