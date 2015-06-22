class QuestionsController < ActionController::Base
  def index
    @questions = Question.order(created_at: :desc)
  end

  def show
    @question = Question.find(params[:id])
  end
end
