class PollOption < ActiveRecord::Base
  # attr_accessible :title, :body
	belongs_to :poll
	has_many :votes
end
