class Question < ActiveRecord::Base
  attr_accessible :body, :title, :user_id
  belongs_to :user
  has_many :answers
end
