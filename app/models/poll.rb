class Poll < ActiveRecord::Base
  attr_accessible :title, :body
	
	has_many :poll_options
	has_many :votes, :through=>:poll_options
	belongs_to :user
	belongs_to :room
	validates_presence_of :user_id, :room_id
	
	def correct_poll_option
		self.poll_options.where(:id=>correct_poll_option_id)
	end

	def poll_options_vote_count
		poll_option_count_map = {}

		self.poll_options.each do |poll_option|
			poll_option_count_map[poll_option] = poll_option.vote_count
		end
	end
end