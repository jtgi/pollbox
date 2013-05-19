class PollOption < ActiveRecord::Base
  attr_accessible :option
	belongs_to :poll
	has_many :votes

	validates_presence_of :poll_id

	def correct?
		self.poll.correct_poll_option_id == id
	end
end
