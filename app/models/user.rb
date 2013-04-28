class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name
  
  #has many relationship
  has_many :registrations
  has_many :rooms, :through => :registrations
  # attr_accessible :title, :body

  has_many :questions

  has_many :answers

  def owns_room?(room_id)
    !self.rooms.find_by_id(room_id).nil?
  end
  def rooms_created
    self.rooms.where("user_level = ?", 1)
  end

  def rooms_registered
    self.rooms.where("user_level = ?", 0)
  end

  def send_on_create_confirmation_instructions
    devise::mailer.delay.confirmation_instructions(self)
  end
  def send_reset_password_instructions
    desive::mailer.delay.reset_password_instructions(self)
  end

  def send_unlock_instructions
    devise::mailer.delay.unlock_instructions(self)
  end

end
