class QuestionsController < ApplicationController

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
    @question = Question.new(question_params)
    if @question.save
      redirect_to questions_path, notice: 'Ваш вопрос добавлен'
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to question_path, notice: 'Вопрос успешно обновлен'
    else
      render 'questions/edit'
    end
  end

  def destroy
    if @question.destroy
      redirect_to questions_path
    end
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
