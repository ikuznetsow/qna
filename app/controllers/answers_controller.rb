class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_answer, only: [:update]
  before_action :load_question, only: [:create, :destroy, :update, :set_best]

  def create
    @answer = @question.answers.build(answer_params.merge(user: current_user))
    @answer.save
  end

  def update
    @answer.update(answer_params) if current_user.author_of?(@answer)
  end

  def set_best
    if current_user.author_of?(@question)
      @answer = @question.answers.find(params[:answer_id])
      @question.answers.update_all(is_best: false)
      @answer.update(is_best: true)
    end
  end

  def destroy
    @answer = @question.answers.find(params[:id])
    @answer.destroy if current_user.author_of?(@answer)
  end

  private
  def answer_params
    params.require(:answer).permit(:body)
  end

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end
end
