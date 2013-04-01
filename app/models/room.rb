class Room < ActiveRecord::Base
  attr_accessible :name, :maximum_registrants, :owner_id

  #users association
  has_many :registrations
  has_many :users, :through=>:registrations

  #questions association
  has_many :questions
end

