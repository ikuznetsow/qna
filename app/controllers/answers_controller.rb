class AnswersController < ApplicationController

  before_action :load_question, only: [:create]

  def create
    @answer = @question.answers.build(answer_params)

    if @answer.save
      redirect_to @question, notice: 'You answer was successfully created.'
    else
      flash[:notice] = 'Please fill in answer body.'
      redirect_to @question
    end
  end


  private
  def answer_params
    params.require(:answer).permit(:body)
  end

  def load_question
    @question = Question.find(params[:question_id])
  end
end
