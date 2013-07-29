class Comment < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :content

  belongs_to :room
  belongs_to :user


  
end
