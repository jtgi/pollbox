class Poll < ActiveRecord::Base
  attr_accessible :title, :body
	
	has_many :poll_options
	has_many :votes, :through=>:poll_options

	belongs_to :user
	belongs_to :room

end
