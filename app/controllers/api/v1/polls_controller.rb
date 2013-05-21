class Api::V1::PollsController < Api::V1::ApiController
	before_filter :authenticate_user!	
	before_filter :get_parent

	def create
		if !params[:room_id].nil?
				@poll = Poll.new(params[:poll])
				@poll.user_id = current_user.id
				@poll.room_id = params[:room_id]
				authorize! :create, @poll
				if @poll.save
					#return poll
				else
					#return @poll.errors	
				end
		else
			#return error message {"error": "Must have an associated room"}
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

