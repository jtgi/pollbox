class PollsController < ApplicationController
	before_filter :authenticate_user!	
	before_filter :get_parent, :only=>[:index]
  before_filter :find_poll, :only=>[:show, :update, :destroy, :open, :close]

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
    authorize! :destroy, @poll
    @poll.destroy
	end

  def open
    authorize! :update, @poll
    @poll.update_attributes( :open=>true )
	  PrivatePub.publish_to "#{ @poll.room.name }", { poll: @poll.to_json}
  end

  def close
    authorize! :update, @poll
    @poll.update_attributes( :open=>false )
	  PrivatePub.publish_to "#{ @poll.room.name }", { poll: @poll.to_json}
  end

	private
	def get_parent
		@parent = User.find_by_id(params[:user_id]) || Room.find_by_id(params[:room_id])
	end

  def find_poll
		@poll = Poll.find(params[:id])
  end
end
