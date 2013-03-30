class Room < ActiveRecord::Base
  attr_accessible :name, :maximum_registrants
end
