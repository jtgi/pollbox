class Room < ActiveRecord::Base
  attr_accessible :name, :maximum_registrants, :owner_id
end
