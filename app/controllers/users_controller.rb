class UsersController < ApplicationController
  def user
		if current_user.guest?
			current_user.last_used = Time.zone.now
		end
    respond_with(current_user) 
  end
end
