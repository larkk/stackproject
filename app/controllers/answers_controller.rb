class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :load_question, only: [:create, :new, :edit, :destroy]
  before_action :load_answer, only: [:update, :edit, :destroy]

  def new
    @answer = @question.answers.new
  end

  def create
    if @answer = @question.answers.create(answers_params.merge(user: current_user))
      redirect_to @question, notice: 'You create the answer'
    else
      render :new
    end
  end

  def update
    if @answer = @question.answers.update(answers_params.merge(user: current_user))
      redirect_to @question, notice: 'Answer updated'
    else
      render :edit
    end
  end

  def destroy
    if answer.user_id == current_user.id
      @answer.destroy
      redirect_to @question, notice: 'Answer destroy'
    else
      redirect_to @question
    end
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:text)
  end
end