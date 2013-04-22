class RoomsController < ApplicationController
	include RoomsHelper

	before_filter :authenticate_user!


	def index
		@owned_rooms = current_user.rooms_created
		@not_owned_rooms = current_user.rooms_registered
	end

	def update
		#check to see if already registered
		@check = Registration.where("user_id = ? AND room_id = ?", current_user.id, params[:id])
		
		if @check.nil?
			@registration = Registration.new
			@registration.user_id = current_user.id
			@registration.room_id = params[:id]
			#user_level = 1 (registrant)
			@registration.user_level = 0;

			if @registration.save
				flash[:success] = "Registrated Successfully"
				redirect_to rooms_path
			else
				flash[:error] = "Registration Failed"
				redirect_to rooms_path
			end
		else
			flash[:notice] = "Already Registered"
			redirect_to rooms_path
		end
	end

	def new 
		@room = Room.new
	end

	def show
		if userIsRegistered(current_user, params[:id])
			@room = Room.find(params[:id])
		else 
			flash[:error] = "You must be registered for this room to view it"
			redirect_to rooms_path
		end
	end

	def create
		@room = Room.new(params[:room])
		@room.owner_id = current_user.id

		if @room.save
			@registration = Registration.new
			@registration.user_id = current_user.id
			@registration.room_id = @room.id
			#user_level = 0 (registrant)
			@registration.user_level = 1;

			if @registration.save
				flash[:success] = "Room Successfully Created"
				redirect_to :controller=>"rooms", :action=>"show", :id=>@room.id
			end
		else
			flash[:error] = "Registration Failed"
			redirect_to "room/new"
		end
	end
end
