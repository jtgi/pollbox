class Answer < ActiveRecord::Base
  attr_accessible :body, :title
 
  belongs_to :user
  belongs_to :question
	validates_presence_of :user_id, :title, :room_id
  has_one :room, :through=>:question
end
