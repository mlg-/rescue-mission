class AnswersController < ApplicationController
  def new
    @answer = Answer.new
  end

  def create
    @answer = Answer.new(answer_params)

    if @answer.save
      redirect_to question_path(params[:question_id])
    else
      @question = Question.find(params[:question_id])
      @body = Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(@question.body)
      flash[:notice] = @answer.errors.full_messages
      render 'questions/show'
    end
  end

  def show
    @answer = Answer.find(params[:id])
  end

  def update
    @answer = Answer.find(params[:id])
    Answer.only_one_best_answer(@answer.question_id)

    if @answer.update(best_answer: true)
      flash[:notice] = "You have marked a best answer"
      redirect_to question_path(@answer.question_id)
    else
      flash[:notice] = @answer.errors.full_messages
      render 'questions/show'
    end
  end

  protected
  def answer_params
    params.require(:answer).permit(:description, :user, :question, :best_answer).merge(user_id: current_user.id, question_id: params[:question_id])
  end
end
