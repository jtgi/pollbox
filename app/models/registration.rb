class Registration < ActiveRecord::Base
  attr_accessible :created_at, :room_id, :user_id
  belongs_to :room
  belongs_to :user
end
