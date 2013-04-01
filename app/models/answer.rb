class Answer < ActiveRecord::Base
  attr_accessible :body, :question_id, :title, :user_id
 
  belongs_to :user
  belongs_to :question

  has_one :room, :through=>:question
end
