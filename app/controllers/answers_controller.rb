class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: [:create, :destroy, :edit, :update]
  before_action :load_answer, only: [:edit, :update]

  def edit

  end

  def create
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user

    if @answer.save
      flash[:success] = 'You answer was successfully created.'
    else
      flash[:notice] = 'Please fill in answer body.'
    end
    redirect_to @question
  end

  def update
    if current_user.author_of?(@answer)
      @answer.update(answer_params)
      flash[:success] = 'Your answer was successfully updated.'
    else
      flash[:notice] = "You haven't access for this action."
    end
    redirect_to @question
  end

  def destroy
    @answer = @question.answers.find(params[:id])
    if current_user.author_of?(@answer)
      @answer.destroy
      flash[:success] = 'Your answer was deleted.'
    else
      flash[:notice] = "You haven't access for this action."
    end
    redirect_to @question
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
