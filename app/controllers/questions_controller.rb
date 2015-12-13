class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_question, only: [:show, :destroy, :edit, :update]

  def index
    @questions = Question.all
  end

  def show
    @answer = @question.answers.build
  end

  def new
    @question = Question.new
  end

  def edit

  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user

    if @question.save 
      flash[:success] = 'Your question successfully created.'
      redirect_to @question
    else
      render :new
    end
  end

  def update
    if current_user.author_of?(@question)
      @question.update(question_params)
      flash[:success] = 'Your question successfully updated.'
    else
      flash[:notice] = "You haven't access for this action."
    end
    redirect_to @question
  end

  def destroy
    if current_user.author_of?(@question)
      @question.destroy
      flash[:success] = 'Your question was deleted.'
      redirect_to questions_path
    else
      flash[:notice] = "You haven't access for this action."
      redirect_to @question
    end
  end

  private
  def question_params
    params.require(:question).permit(:title, :body)
  end

  def load_question
    @question = Question.find(params[:id])
  end
end