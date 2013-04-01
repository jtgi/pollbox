class Question < ActiveRecord::Base
  attr_accessible :body, :title, :user_id, :room_id

  belongs_to :room
  belongs_to :user
  has_many :answers

end
