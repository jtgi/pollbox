class RegistrationsController < ApplicationController
	def create
		@room = Room.find(params[:registration][:room_id])
		
		@subscription = Subscription.new(params[:registration])
		room_id = params[:registration][:room_id]
		if @subscription.save 
		else
		end
	end

	def destroy
		Subscription.where("user_id = ? AND room_id = ?", params[:registration][:user_id], params[:registration][:room_id]).destroy
	end

end
