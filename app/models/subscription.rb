class Subscription < ActiveRecord::Base
  attr_accessible :created_at
  belongs_to :room
  belongs_to :user
	validates_presence_of :user
  validates_presence_of :room
end
