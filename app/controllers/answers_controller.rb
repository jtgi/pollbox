class AnswersController < ApplicationController
	before_filter :authenticate_user!
	before_filter :get_question, :only=>[:index, :new] 
	def index
		
	end

	def new
		@question = Question.new

	end

	def get_question
		@question = Question.find(params[:question_id])
	end

end
