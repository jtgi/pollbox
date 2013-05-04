class PollsController < ApplicationController
	
	before_filter :get_parent

	def create
		if !params[:room_id].nil?
			@poll = Poll.new(params[:poll])
			@poll.user_id = current_user.id
			@poll.room_id = params[:room_id]
			if @poll.save
				#return poll
			else
				#return @poll.errors	
			end
		else
			#return error message {"error": "Must have an associated room"}
	end

	def update
		if current_user.owns_poll?(params[:id])
			@poll = Poll.find(params[:id])
			@poll.update_attributes(params[:poll])
		end
	end
	
	def index
		@polls = @parent.polls
	end
	
	def show
		@poll = Poll.find_by_id(params[:id])
		if current_user.is_registered_for(@poll.room_id)
			#return @poll in json
		else
			#show error message {error: "you do not have permission to view this poll"}
		end
	end

	def destroy
		if current_user.owns_poll?(params[:id])
			Poll.find(params[:id]).destroy
		else
			#return {error: "You dont have permission to delete this poll"}
		end
	
	end

	private
	def get_parent
		@parent = User.find_by_id(params[:user_id]) || Room.find_by_id(params[:room_id])
	end

end
