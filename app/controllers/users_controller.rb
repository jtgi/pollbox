class UsersController < ApplicationController
  def user
		if current_user.guest?
			current_user.last_used = Time.zone.now
		end
    respond_with(current_user) unless current_user == nil
  end
  
  def guest_user
    #create guest user
    @user = User.new(:first_name=>"guest", :email=>"guest_#{Time.new.to_i}#{rand(99)}@guest.com")
    @user.is_guest = true
    @user.save(:validate=>false)
    session[:guest_user_id] = user.id
    respond_with(@user)
  end
end
