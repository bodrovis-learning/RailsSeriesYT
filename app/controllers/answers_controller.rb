# frozen_string_literal: true

class AnswersController < ApplicationController
  include QuestionsAnswers
  include ActionView::RecordIdentifier

  before_action :set_question!
  before_action :set_answer!, except: :create
  before_action :authorize_answer!
  after_action :verify_authorized

  def update
    if @answer.update answer_update_params
      respond_to do |format|
        format.html do
          flash[:success] = t '.success'
          redirect_to question_path(@question, anchor: dom_id(@answer))
        end

        format.turbo_stream do
          @answer = @answer.decorate
          flash.now[:success] = t '.success'
        end
      end
    else
      render :edit
    end
  end

  def edit; end

  def create
    @answer = @question.answers.build answer_create_params

    if @answer.save
      respond_to do |format|
        format.html do
          flash[:success] = t '.success'
          redirect_to question_path(@question)
        end

        format.turbo_stream do
          @answer = @answer.decorate
          flash.now[:success] = t '.success'
        end
      end
    else
      load_question_answers(do_render: true)
    end
  end

  def destroy
    @answer.destroy
    respond_to do |format|
      format.html do
        flash[:success] = t '.success'
        redirect_to question_path(@question), status: :see_other
      end

      format.turbo_stream { flash.now[:success] = t('.success') }
    end
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

  def authorize_answer!
    authorize(@answer || Answer)
  end
end
