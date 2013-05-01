class AnswersController < ApplicationController
	before_filter :authenticate_user!
	before_filter :get_parent, :only=>[:index, :new] 
	def index
		@answers = @parent.answers
	end

	def new
		@answer = Answer.new
	end

	def show
		@answer = Answer.find(params[:question_id])
	end
	
	private 
	def get_parent
		@question = Question.find_by_id(params[:room_id])
		@user = User.find_by_id(params[:user_id])

		@parent = @room || @user
	end
end
