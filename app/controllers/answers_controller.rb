class AnswersController < ApplicationController
	#before_filter :authenticate_user!
	before_filter :authenticate_room_registration
	before_filter :get_parent, :only=>[:index] 

	def index
		@answers = @parent.answers
	end

	def show
		@answer = Answer.find(params[:question_id])
    authorize! :read, @answer
	end

	def create
		@question = Question.find(params[:question_id])
		@answer = Answer.new(params[:answer])
		@answer.question = @question

		if @answer.save
			#return @answer
      PrivatePub.publish_to "#{@answer.question.room.name}/master", {answer: @answer.to_json}
		else
			#return {"error":"Error with save"}
		end
	end

	def update

		@answer = Answer.find(params[:id])
    authorize! :update, @answer
		@answer.update_attributes(params[:question])
	end
	
	private 
	def get_parent
		@question = Question.find_by_id(params[:room_id])
		@user = User.find_by_id(params[:user_id])
		@parent = @question || @user
	end

end
