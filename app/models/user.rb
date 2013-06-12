class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name
  
  #has many relationship
  has_many :subscriptions, :dependent=>:destroy
  has_many :rooms, :through => :subscriptions
  # attr_accessible :title, :body

  has_many :questions

  has_many :answers

	has_many :votes

	has_many :polls

	def admin?
		false
	end

  def voted_for?(poll_option_id)
    if self.votes.find_by_poll_option_id(poll_option_id)
      return true
    end
    return false
  end

  def owns_room?(room_id)
    !self.subscriptions.find_by_room_id(room_id).user_level == 3
		subscription = self.subscriptions.find_by_id(room_id)
		if !subscription.nil?
			return subscription.user_level == 3
		end
		return false
	end
	
	def owns_question?(question_id)
		!self.questions.find_by_id(question_id).nil?
	end

	def owns_answer?(answer_id)
		!self.answers.find_by_id(answer_id).nil?
	end

	def owns_poll?(poll_id)
		!self.answers.find_by_id(poll_id).nil?
	end
	
  def rooms_created
    self.rooms.where("user_level = ?", 3)
  end

  def rooms_subscribed
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
	def is_subscribed_to(room_id)
		!self.subscriptions.where("room_id = ?", room_id).empty?
	end

end
