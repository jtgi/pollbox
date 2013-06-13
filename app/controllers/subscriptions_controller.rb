class SubscriptionsController < ApplicationController
	before_filter :authenticate_user!
	def create
		@room = Room.find(params[:subscription][:room_id])
		@subscription = Subscription.new(params[:subscription])
		room_id = params[:room_id] || params[:subscription][:room_id]
		user_id = current_user.id
		@subscription.room_id = room_id
		@subscription.user_id = user_id

		if @subscription.save 
		else
		end
	end

	def destroy
		room_id = params[:room_id] || params[:subscription][:room_id]
		user_id = current_user.id
		Subscription.where("user_id = ? AND room_id = ?", user_id, room_id).destroy
	end

end
