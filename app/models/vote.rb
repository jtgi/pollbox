class Vote < ActiveRecord::Base
  # attr_accessible :title, :body
	belongs_to :poll_option
	belongs_to :user
	validates_presence_of :user_id, :poll_option_id
  before_save :clear_user_votes

  def clear_user_votes
    self.poll_option.poll.clear_user_votes(self.user_id)
  end
	
end
