class AnswersController < ApplicationController
	before_filter :authenticate_user!
	before_filter :authenticate_room_registration
	before_filter :get_parent, :only=>[:index] 

	def index
		@answers = @parent.answers
	end

	def new
		@answer = Answer.new
	end

	def show
		@answer = Answer.find(params[:question_id])
	end

	def create
		if !params[:question_id].nil?
			@question = Question.find(params[:question_id])
			if current_user.is_registered_for(@question.room_id)
				@answer = Answer.new(params[:answer])
				@answer.question_id = params[:question_id]
				if @answer.save
					#return @answer
				else
					#return {"error":"Error with save"}
				end
			else
				#return {"error":"You do not have permission to create this answer"}
			end
		else
			#return {"Error": "Must be associated with a question"}
		end
	end
	def update
		if current_user.owns_answer?(params[:id])
			@answer = Answer.find(params[:id])
			@answer.update_attributes(params[:question])
		else
			#return {"error": "You do not have permission to update this answer"}
		end
	end
	
	private 
	def get_parent
		@question = Question.find_by_id(params[:room_id])
		@user = User.find_by_id(params[:user_id])

		@parent = @room || @user
		
	end

	private 
	def authenticate_room_registration
		if params[:room_id]	
		end
	end
end
