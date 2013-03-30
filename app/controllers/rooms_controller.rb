class RoomsController < ApplicationController
	include RoomsHelper

	before_filter :authenticate_user!

	def index
		@rooms = current_user.room
	end

	def new 
		@room = Room.new
	end

	def show
		if userIsRegistered(current_user, params[:id])

		else 
			flash[:error] = "You must be registered for this room to view it"
			redirect_to rooms_path
		end
	end

	def create
		@room = Room.new(params[:room])
		if @room.save
			@registration = Registration.new
			@registration.user_id = current_user.id
			@registration.room_id = @room.id
			if @registration.save
				flash[:success] = "Room Successfully Created"
				redirect_to rooms_path
			end
		else
			flash[:error] = "Registration Failed"
			redirect_to "room/new"
		end
	end
end
