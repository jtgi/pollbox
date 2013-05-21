class Api::V1::QuestionsController < Api::V1::ApiController
	before_filter :get_parent, :only=>[ :index, :new ]
	before_filter :authenticate_user!

	def create
		if params[:room_id].nil?
			if current_user.is_registered_for(params[:room_id])
				@question = Question.new(params[:room])
				@question.user_id = current_user.id
				@question.room_id = params[:room_id]
			else
				#return {"error":"Must be registered for room"}
			end
		else
			#return {"error":"Must have an associated room"}
		end
	end

	def edit
		@question = Question.find(params[:id]) 
	end

	def update
		if current_user.owns_question?(params[:id])
			@question = Question.find(params[:id])
			@question.update_attributes(params[:room])
		else
			#return {"error": "You do not have permission to update this question"}
		end
	end

	def show
		@question = Question.find(params[:id])
		if current_user.is_registered_for(@question.room_id)
					
		else
		 #return {"error": "You do not have permission to view this question"}
		end
	end

	def index
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
	
	private 
	def get_parent
		room = Room.find_by_id(params[:room_id])
		user = User.find_by_id(params[:user_id])
		@parent = room || user	
	end
end
