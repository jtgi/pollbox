class PollOptionsController < ApplicationController
  before_filter :clear_user_votes, :only=>[:vote]

	def create
	end

	def update
	end
	
	def destroy
	end

  def vote
    @poll_option = PollOption.find(params[:id])
    @vote = Vote.new 
    @vote.user = current_user
    @vote.poll_option = @poll_option
    authorize! @vote

    if @vote.save
      #publish updated count
      #PrivatePub.publish_to "#{@poll_option.poll.room.name}/master", {vote:}
      #return success
    else
      #return error
    end
  end
end
