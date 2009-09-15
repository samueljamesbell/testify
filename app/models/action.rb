class Action < ActiveRecord::Base

	validates_presence_of :object_type, :object_id, :action_type

  
end
