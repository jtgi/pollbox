class Room < ActiveRecord::Base
  attr_accessible :name, :maximum_registrants, :description

  validates :name, :presence=>true, :uniqueness=>true
  validates :owner_id, :presence=>true
  #users association
  has_many :registrations
  has_many :users, :through=>:registrations

  #questions association
  has_many :questions

	has_many :polls

  #sunspot searching
  searchable do 
  	text :name, :default_boost => 2
    text :description
  end

end

