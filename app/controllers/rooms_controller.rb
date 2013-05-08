class RoomsController < ApplicationController
	include RoomsHelper

	before_filter :authenticate_user!
	respond_to :html, :json


	def index
		@rooms = current_user.rooms
	end

	def new 
		@room = Room.new
	end

	def show
		#@room = current_user.rooms.find(params[:id])
		@room = Room.find(params[:id])
		authorize! :read, @room
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
				respond_to do |format|
					format.json { render :json=>@user }
				end
				#flash[:success] = "Room Successfully Created"
				#redirect_to room_path(@room)
			end
			#flash[:error].now = "Room was not able to be created"
			#render :action=>"new"
		end
	end
	
	def update
			@room = Room.new(params[:id])
			authorize! :update, @room
			if @room.update_attributes(params[:room])
			 
				#flash[:success] = "Room Successfully Updated"
				#redirect_to show_room_path(@room)
			else
				#flash[:error].now = "Registration Failed"
				#render :action=>"edit"
  	  end
	end

	def destroy
		@room = Room.find(params[:id])
		authorize! :destroy, @room
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

