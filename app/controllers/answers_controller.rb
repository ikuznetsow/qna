class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: [:create, :destroy, :update, :set_best]
  before_action :load_answer, only: [:update, :destroy, :set_best]

  def create
    @answer = @question.answers.create(answer_params.merge(user: current_user))
  end

  def update
    @answer.update(answer_params) if current_user.author_of?(@answer)
  end

  def set_best
    if current_user.author_of?(@question)
      @question.answers.update_all(is_best: false)
      @answer.update(is_best: true)
    end
  end

  def destroy
    @answer.destroy if current_user.author_of?(@answer)
  end

  private
  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:file, :id, :_destroy])
  end

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = @question.answers.find(params[:id])
  end
end
