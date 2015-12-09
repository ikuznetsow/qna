class QuestionsController < ApplicationController
	before_action :load_question, only: [:show, :destroy]
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
		@question.user_id = current_user.id

		if @question.save 
			flash[:notice] = 'Your question successfully created.'
			redirect_to @question
		else
			render :new
		end
	end

	def destroy
		if @question.user_id == current_user.id
      @question.destroy
      flash[:success] = 'Your question was deleted.'
	    redirect_to questions_path
    else
      flash[:notice] = "You haven't access for this action"
			redirect_to @question
    end
	end

	private
	def question_params
		params.require(:question).permit(:title, :body, :user_id, answers_attibutes: [:body])
	end

	def load_question
		@question = Question.find(params[:id])
	end
end