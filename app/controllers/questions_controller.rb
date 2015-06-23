class QuestionsController < ApplicationController
  def index
    @questions = Question.order(created_at: :desc)
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
       flash[:notice] = "Your question has been added."
       redirect_to questions_path
    else
      flash[:error] = @question.errors.full_messages.join(". ")
      render :new
    end
  end

  protected
  def question_params
    params.require(:question).permit(:title, :body)
  end

end
