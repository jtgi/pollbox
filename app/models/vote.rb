class Vote < ActiveRecord::Base
  # attr_accessible :title, :body
	belongs_to :poll_option
	belongs_to :user
	
end
