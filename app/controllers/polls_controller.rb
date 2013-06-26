class PollsController < ApplicationController
	before_filter :authenticate_user!	
	before_filter :get_parent

	def create
		@poll = Poll.new(params[:poll])
		@poll.user = current_user
		@poll.room = Room.find(params[:room_id])
		authorize! :create, @poll
      
		if @poll.save
			#return poll
		else
			#return @poll.errors	
		end
	end

	def update
		@poll = Poll.find(params[:id])
		authorize! :update, @poll
		@poll.update_attributes(params[:poll])
	end
	
	def index
		@polls = @parent.polls
	end
	
	def show
    authorize! :read, @poll
		@poll = Poll.where(:id=>params[:id]).includes(:poll_options)
	end

	def destroy
    @poll = Poll.find(params[:id])
    authorize! :destroy, @poll
    @poll.destroy
	end

	private
	def get_parent
		@parent = User.find_by_id(params[:user_id]) || Room.find_by_id(params[:room_id])
	end
end
