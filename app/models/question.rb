class Question < ActiveRecord::Base
  attr_accessible :body, :title, :user_id, :room_id

  validates :body, :presence=>true
  validates :title, :presence=>true
  validates :user_id, :presence=>true
  validates :room_id, :presence=>true

  belongs_to :room
  belongs_to :user
  has_many :answers

  searchable do 
  	text :title, :default_boost => 2
  	text :body
  end

end
