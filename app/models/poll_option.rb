class PollOption < ActiveRecord::Base
  attr_accessible :option
	belongs_to :poll
	has_many :votes
end
