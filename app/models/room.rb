class Room < ActiveRecord::Base
  attr_accessible :name, :maximum_registrants, :description#, :password , :password_confirmation
	
	#validates :password, :confirmation=>true

	#before_save :encrypt_password
	#validates_confirmation_of :password

	#def self.authenticate(name, password)
	#	room = find_by_name(name)
	#end

	#before_save :encrypt_password

  validates :name, :presence=>true, :uniqueness=>true
  validates_presence_of :owner_id
  #users association
  has_many :registrations, :dependent=>:destroy
  has_many :users, :through=>:registrations

  #questions association
  has_many :questions, :dependent=>:destroy

	has_many :polls, :dependent=>:destroy

  #sunspot searching
#  searchable do 
#  	text :name, :default_boost => 2
#    text :description
#  end
	

end

