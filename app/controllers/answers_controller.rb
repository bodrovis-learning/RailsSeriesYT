# frozen_string_literal: true

class AnswersController < ApplicationController
  include QuestionAnswers
  include ActionView::RecordIdentifier

  before_action :set_question!
  before_action :set_answer!, except: :create

  def update
    if @answer.update answer_update_params
      flash[:success] = t '.success'
      redirect_to question_path(@question, anchor: dom_id(@answer))
    else
      render :edit
    end
  end

  def edit; end

  def create
    @answer = @question.answers.build answer_create_params

    if @answer.save
      flash[:success] = t '.success'
      redirect_to question_path(@question)
    else
      load_question_answers rerender: true
    end
  end

  def destroy
    @answer.destroy
    flash[:success] = t '.success'
    redirect_to question_path(@question)
  end

  private

  def answer_create_params
    params.require(:answer).permit(:body).merge(user: current_user)
  end

  def answer_update_params
    params.require(:answer).permit(:body)
  end

  def set_question!
    @question = Question.find params[:question_id]
  end

  def set_answer!
    @answer = @question.answers.find params[:id]
  end
end
