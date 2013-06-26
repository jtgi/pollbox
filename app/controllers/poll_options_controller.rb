class PollOptionsController < ApplicationController

	def create
    @poll_option = PollOption.new(params[:poll_option])
    authorize! :create, @poll_option

	end

	def update
    @poll_option = PollOption.find(params[:id])
    authorize! :update, @poll_option
    @poll_option.update_attributes(params[:poll_option])
	end
	
	def destroy
    @poll_option = PollOption.find(params[:id])
    authorize! :destroy, @poll_option
    @poll_option.destoy
	end

  def vote
    @poll_option = PollOption.find(params[:id])
    @vote = Vote.new 
    @vote.user = current_user
    @vote.poll_option = @poll_option
    authorize! :create, @vote

    if @vote.save
      #publish updated count
      PrivatePub.publish_to "#{@poll_option.poll.room.name}/master", { vote: @vote.to_json}
      #return success
    else
      #return error
    end
  end
end
