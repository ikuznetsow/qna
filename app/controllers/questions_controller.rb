class QuestionsController < ApplicationController
	before_action :load_question, only: [:show]
	before_action :authenticate_user!, except: [:index,:show]

	def index
		@questions = Question.all
	end

	def show
		@answer = @question.answers.build
	end

	def new
		@question = Question.new
	end

	def create
		@question = Question.new(question_params)

		if @question.save 
			flash[:notice] = 'Your question successfully created.'
			redirect_to @question
		else
			render :new
		end
	end

	private
	def question_params
		params.require(:question).permit(:title, :body, answers_attibutes: [:body])
	end

	def load_question
		@question = Question.find(params[:id])
	end
end
