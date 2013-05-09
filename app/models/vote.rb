class Vote < ActiveRecord::Base
  # attr_accessible :title, :body
	belongs_to :poll_option
	belongs_to :user
	validates_presence_of :user_id, :poll_id
	
end
