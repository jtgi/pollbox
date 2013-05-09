class Poll < ActiveRecord::Base
  attr_accessible :title, :body
	
	has_many :poll_options
	has_many :votes, :through=>:poll_options
	belongs_to :user
	belongs_to :room
	validates_presence_of :user_id, :room_id, :title
	
	def correct_poll_option
		self.poll_options.where(:id=>correct_poll_option_id)
	end
end
