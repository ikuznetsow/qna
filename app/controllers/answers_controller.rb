class AnswersController < ApplicationController

	before_action :load_question, only: [:new, :create]

	def new
    @answer = @question.answers.new
  end

	def create
		@answer = @question.answers.create(answer_params)

		if @answer.save
      redirect_to @question, notice: 'You answer was successfully created.'
    else
      render :new 
    end
	end


	private
	def answer_params
		params.require(:answer).permit(:question_id, :body)
	end

	def load_question
    @question = Question.find(params[:question_id])
  end
end
