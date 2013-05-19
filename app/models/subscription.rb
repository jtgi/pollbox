class Subscription < ActiveRecord::Base
  attr_accessible :created_at, :room_id, :user_id
  belongs_to :room
  belongs_to :user
	validates_presence_of :user_id, :room_id
end
