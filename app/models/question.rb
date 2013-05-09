class Question < ActiveRecord::Base
  attr_accessible :body, :title

  belongs_to :room
  belongs_to :user
  has_many :answers

  validates_presence_of :user_id, :room_id, :title

  #searchable do 
  #	text :title, :default_boost => 2
  #	text :body
  #end

end
