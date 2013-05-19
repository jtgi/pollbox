class RegistrationsController < ApplicationController
	def create
		@room = Room.find(params[:registration][:room_id])
		
		@registration = Registration.new(params[:registration])
		room_id = params[:registration][:room_id]
		if @registration.save 
		else
		end
	end

	def destroy
		Registration.where("user_id = ? AND room_id = ?", params[:registration][:user_id], params[:registration][:room_id]).destroy
	end

end
