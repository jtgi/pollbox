class Api::V1::PollOptionsController < Api::V1::ApiController
	before_filter :find_poll
	before_filter :delete_previous_vote
	def create
		@poll_option = @poll.poll_options.find(params[:poll_option_id])
	end

	def update
		
	end
	
	def destroy
	end

	private
	def delete_previous_vote
		@poll.delete_previous_vote
	end

	private 
	def find_poll
		@poll = params[:poll_id]
	end
end
