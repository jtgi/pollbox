class Answer < ActiveRecord::Base
  attr_accessible :body, :title
 
  belongs_to :user
  belongs_to :question

  has_one :room, :through=>:question
end
