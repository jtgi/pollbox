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
		@user = current_user
		@room = @user.rooms.build(:params[:room])
		if @room.save
			@subscription = Subscription.where("room_id=? AND user_id = ?", @room.id, current_user.id).first
			@subscription.user_level = 3
			if @subscription.save

			end
			#flash[:error].now = "Room was not able to be created"
			#render :action=>"new"
		end
	end
	
	def update
			@room = Room.find(params[:id])
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
		@room.destroy
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

