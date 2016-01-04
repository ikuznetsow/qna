class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_answer, only: [:update]
  before_action :load_question, only: [:create, :destroy, :update, :set_best]

  def create
    # POST   /questions/:question_id/answers(.:format)   answers#create
    # http://stackoverflow.com/questions/10124832/how-can-i-elegantly-handle-devises-401-status-in-ajax

    @answer = @question.answers.build(answer_params.merge(user: current_user))
    @answer.save
    # respond_to do |format|
    #   if @answer.save
    #     format.html { redirect_to @question, notice: 'Your answer was successfully created.' }
    #     
    #   else
    #     format.html { render @question, notice: @answer.errors.full_messages.to_sentence }
    #     format.json { render json: @answer.errors } #, status: :unprocessable_answer
    #   end
    # end
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
