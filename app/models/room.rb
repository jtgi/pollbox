class Room < ActiveRecord::Base
  attr_accessible :name, :maximum_registrants, :owner_id, :description

  validates :name, :presence=>true, :uniqueness=>true
  validates :owner_id, :presence=>true
  validates :description, :presence=>true
  #users association
  has_many :registrations
  has_many :users, :through=>:registrations

  #questions association
  has_many :questions


  #sunspot searching
  searchable do 
  	text :name, :default_boost => 2
    text :description
  end

end

