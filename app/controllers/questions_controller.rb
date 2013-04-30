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
		@room = params[:room_id]
		@user = params[:user_id]
		@questions = @parent.questions
	end
	
	private 
	def get_parent
		@room = Room.find_by_id(params[:room_id])
		@user = User.find_by_id(params[:user_id])
		@parent = @room || @user	
	end
end
