class Email < ActiveRecord::Base
	validates_presence_of :address
	validates_format_of :address, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
end
