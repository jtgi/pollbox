class RoomsController < ApplicationController
	include RoomsHelper
	before_filter :authenticate_user!
	before_filter :find_room, :except=>[:index, :create]
	before_filter :check_for_pass_code, :only=>[:show]

	def index
		@rooms = current_user.rooms
	end

	def show
		#@room = current_user.rooms.find(params[:id])
		#@room = Room.find(params[:id])
		authorize! :read, @room
	end

	def create
		@user = current_user
		@room = @user.rooms.build(params[:room])
    if @user.save
			@subscription = @room.subscriptions.first
			#@subscription = Subscription.where("room_id=? AND user_id = ?", @room.id, current_user.id).first
			@subscription.user_level = 3
			if @subscription.save
        respond_with(@room)
			end
			#flash[:error].now = "Room was not able to be created"
			#render :action=>"new"
		end
	end
	
	def update
		#@room = Room.find(params[:id])
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
		#@room = Room.find(params[:id])
		authorize! :destroy, @room
		@room.destroy
	end

	private
	def check_for_pass_code
		if @room.has_pass_code
			pass_code_submitted = cookies[:pass_code]
			if pass_code_submitted != @room.pass_code
				raise Exception::InvalidPassCodeException.new
			end
		end
	end

	private
	def find_room
		@room = current_user.rooms.find(params[:id])
	end

end
