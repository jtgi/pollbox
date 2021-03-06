class QuestionsController < ApplicationController
	before_filter :get_parent, :only=>[ :index ]
  before_filter :get_question, :only=>[ :update, :destroy, :show ]
	#before_filter :authenticate_user!

	def create
    @question = Question.new(params[:room])
    @question.user = current_user
    @question.room = Room.find(params[:room_id])
    authorize! :create, @question
    PrivatePub.publish_to "#{@question.room.name}/master", {question: @question.to_json}
	end

	def update
    authorize! :update, @question
		@question.update_attributes(params[:room])
	end

	def show
    authorize! :read, @question
    
	end

	def index
    authorize! :read, @room
		if @parent.class == Room
			if current_user.is_registered_for(params[:room_id])
				@questions = @parent.questions
			else
				#return {"error": "You do not have permission to view these questions"}
			end
		end

		if @parent.class == User
			if current_user.id == params[:user_id]
				@questions = @parent.questions
			else
				#return {"error": "You do not have permission to view these questions"}
			end
		end
	end

  def destroy
    authorize! :destroy, @question
    @question.destroy
  end
	
	private 
	def get_parent
		room = Room.find_by_id(params[:room_id])
		user = User.find_by_id(params[:user_id])
		@parent = room || user	
	end

  def get_question
    @question = Question.find(params[:id])
  end

end
