class RoomsController < ApplicationController
	include RoomsHelper

	before_filter :authenticate_user!


	def index
		@owned_rooms = current_user.rooms_created
		@not_owned_rooms = current_user.rooms_registered
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
                redirect_to room_path(@room)
			end
		else
			flash[:error].now = "Room was not able to be created"
            render :action=>"new"
		end
	end
	
	def update
		@room = Room.new(params[:id])
        if @room.update_attributes(params[:room])
			flash[:success] = "Room Successfully Updated"
			redirect_to show_room_path(@room)
		else
			flash[:error].now = "Registration Failed"
            render :action=>"edit"
        end
	end

	def edit
		@room = Room.find(params[:id])
	end

end
#    	def update
#		#check to see if already registered
#		@check = Registration.where("user_id = ? AND room_id = ?", current_user.id, params[:id])
#		
#		if @check.nil?
#			@registration = Registration.new
#			@registration.user_id = current_user.id
#			@registration.room_id = params[:id]
#			#user_level = 1 (registrant)
#			@registration.user_level = 0;
#
#			if @registration.save
#				flash[:success] = "Registrated Successfully"
#				redirect_to rooms_path
#			else
#                flash[:error].now = "Registration Failed"
#                render :action=>"edit"
#			end
#		else
#			flash[:error] = "U"
#			redirect_to rooms_path
#		end
#	end
#

