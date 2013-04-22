class QuestionsController < ApplicationController
	before_filter :get_parent, :only=>[ :index, :new ]
	before_filter :authenticate_user!

	def new
		@question = Question.new
	end

	def create
	end

	def edit
		@question = Question.find(params[:id]) 
	end

	def update

	end

	def show
		@question = Question.find(params[:id])
	end

	def index
		@questions = @parent.questions
	end
	
	private 
	def get_parent
		@parent = Room.find(params[:room_id]) || User.find(params[:user_id])
	end


end
