class PollsController < ApplicationController
	
	before_filter :get_parent

	def create
		if !params[:room_id].nil?
			if current_user.owns_room?(params[:room_id])
				@poll = Poll.new(params[:poll])
				@poll.user_id = current_user.id
				@poll.room_id = params[:room_id]
				if @poll.save
					#return poll
				else
					#return @poll.errors	
				end
			else
				#return error message {"error": "You do not have permission to create a poll in this room"}
			end
		else
			#return error message {"error": "Must have an associated room"}
	end
	end

	def update
		if current_user.owns_poll?(params[:id])
			@poll = Poll.find(params[:id])
			@poll.update_attributes(params[:poll])
		else
			#return error message {"error" : "You do not have permission to update this poll"}
		end
	end
	
	def index
		@polls = @parent.polls
	end
	
	def show
		@poll = Poll.where(:id=>params[:id]).includes(:poll_options)
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

