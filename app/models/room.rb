class Room < ActiveRecord::Base
  attr_accessible :name, :maximum_registrants, :description, :passcode#, :password , :password_confirmation
	
	#before_save :encrypt_password
  validates :name, :presence=>true, :uniqueness=>true
  #users association
  has_many :subscriptions, :dependent=>:destroy
  has_many :users, :through=>:subscriptions

  #questions association
  has_many :questions, :dependent=>:destroy

  has_many :polls, :dependent=>:destroy

	def has_pass_code
		self.pass_code != nil || self.pass_code == ''
	end
	#def get_owner
	#	self.subscriptions.where(:room_id=>self.id, :user_level=>3).first.user
	#end

	def user_is_owner(user_id)
		!self.subscriptions.where(:room_id=>self.id, :user_id=>user_id, :user_level=>3).empty?
	end

  def owner
    self.subscriptions.where("user_level=3").first.user
  end

  #sunspot searching
#  searchable do 
#  	text :name, :default_boost => 2
#    text :description
#  end
end

