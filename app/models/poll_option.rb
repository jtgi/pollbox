class PollOption < ActiveRecord::Base
  attr_accessible :option
	belongs_to :poll
	has_many :votes

	def correct?
		self.poll.correct_poll_option_id == id
	end
end
