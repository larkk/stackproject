class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :load_question, only: [:show, :edit, :update, :destroy]


  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def show
    @answer = @question.answers.build
  end

  def create
    @question = Question.new(questions_params.merge(user: current_user))
    if @question.save
      redirect_to questions_path, notice: 'Your question is created.'
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to @question, notice: 'Your question was successfully updated'
    else
      render 'edit'
    end
  end
  def delete
    @question = Question.find(params[:id])
  end
  
  def destroy
    if @question.user_id == current_user.id
    @question.destroy
    redirect_to questions_path, notice: "The question '#{@question.title}' deleted"
    end
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :text)
  end
end