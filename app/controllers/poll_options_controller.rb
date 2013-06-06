class PollOptionsController < ApplicationController
  before_filter :clear_user_votes, :only=>[:vote]
	def create
	end

	def update
	end
	
	def destroy
	end

  def vote
    @vote = Vote.new 
    @vote.user = current_user
    @vote.poll_option = PollOption.find(params[:id])
    authorize! @vote

    if @vote.save
      #publish to master channel of room
      #return success
    else
      #return error
    end
  end
end
