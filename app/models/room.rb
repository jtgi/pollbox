class Room < ActiveRecord::Base
  attr_accessible :name, :maximum_registrants, :description, :passcode#, :password , :password_confirmation
	
	#validates :password, :confirmation=>true

	#before_save :encrypt_password
	#validates_confirmation_of :password

	#def self.authenticate(name, password)
	#	room = find_by_name(name)
	#end

	#before_save :encrypt_password
	
  validates :name, :presence=>true, :uniqueness=>true
  #users association
  has_many :subscriptions, :dependent=>:destroy
  has_many :users, :through=>:registrations

  #questions association
  has_many :questions, :dependent=>:destroy

	has_many :polls, :dependent=>:destroy

	def has_pass_code
		self.pass_code != nil || self.pass_code == ''
	end
	def get_owner
		self.subscriptions.where(:room_id=>self.id, :user_level=>3).first.user
	end

  #sunspot searching
#  searchable do 
#  	text :name, :default_boost => 2
#    text :description
#  end
	

end

