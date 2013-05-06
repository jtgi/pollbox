class Room < ActiveRecord::Base
  attr_accessible :name, :maximum_registrants, :description, :password #, :password_confirmation
	
	#password protection
	validates :password, :confirmation=>true

	before_save :encrypt_password
	#validates_confirmation_of :password

	def self.authenticate(name, password)
		room = find_by_name(name)
	end




	before_save :encrypt_password

  validates :name, :presence=>true, :uniqueness=>true
  validates :owner_id, :presence=>true
  #users association
  has_many :registrations
  has_many :users, :through=>:registrations

  #questions association
  has_many :questions

	has_many :polls

  #sunspot searching
#  searchable do 
#  	text :name, :default_boost => 2
#    text :description
#  end
	

end

