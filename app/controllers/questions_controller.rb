class QuestionsController < ApplicationController
  def index
    @questions = Question.order(created_at: :desc)
  end

  def show
    @question = Question.find(params[:id])
    @answer = Answer.new
    @answers = Answer.where(question_id: params[:id]).order(created_at: :asc)
  end

  def new
    if user_signed_in?
      @question = Question.new
    else
      flash[:notice] = "You need to be signed in to ask a question."
      redirect_to new_user_session_path
    end
  end

  def create
    @question = Question.new(question_params)

    unless user_signed_in?
      flash[:notice] = "You need to be signed in to ask a question."
      redirect_to new_user_session_path
    end

    if @question.save
       flash[:notice] = "Your question has been added."
       redirect_to questions_path
    else
      flash[:error] = @question.errors.full_messages.join(". ")
      render :new
    end

  end

  def edit
    if user_signed_in?
      @question = Question.find(params[:id])
    else
      flash[:notice] = "You need to be signed in to edit a question."
      redirect_to new_user_session_path
    end
  end

  def update
    unless user_signed_in?
      flash[:notice] = "You need to be signed in to ask a question."
      redirect_to new_user_session_path
    end

    @question = Question.find(params[:id])

    if @question.update(question_params)
       flash[:notice] = "The question has been edited."
       redirect_to question_path(id: @question.id)
    else
      flash[:error] = @question.errors.full_messages.join(". ")
      render :new
    end
  end

  def destroy
    @question = Question.find(params[:id]).delete
    @answers = @question.answers.delete
    flash[:notice] = "The question has been deleted."
    redirect_to questions_path
  end

  protected
  def question_params
    params.require(:question).permit(:title, :body)
  end

end
