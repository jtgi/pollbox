class RoomsController < ApplicationController
	include RoomsHelper
	#before_filter :authenticate_user!
	before_filter :find_room, :except=>[:index, :create]
	before_filter :check_for_pass_code, :only=>[:show]

	def index
		@rooms = current_user.rooms
	end

	def show
		authorize! :read, @room
	end

	def create
		@room = current_user.rooms.build(params[:room])
    authorize! :create
    if @room.save
      @subscription = Subscription.new
      @subscription.user = @user
      @subscription.room = @room
      @subscription.user_level = 3
      @subscription.save
        
		end
	end
	
	def update
		#@room = Room.find(params[:id])
		authorize! :update, @room
		if @room.update_attributes(params[:room])
      respond_with(@room)
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
		#@room = current_user.rooms.find(params[:id])
		@room = current_user.rooms.find(params[:id])
	end

end
