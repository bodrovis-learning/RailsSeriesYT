# frozen_string_literal: true

class CommentsController < ApplicationController
  include QuestionsAnswers
  before_action :set_commentable!
  before_action :set_question

  def create
    @comment = @commentable.comments.build comment_params

    if @comment.save
      flash[:success] = t '.success'
      redirect_to question_path(@question)
    else
      @comment = @comment.decorate
      load_question_answers do_render: true
    end
  end

  def destroy
    comment = @commentable.comments.find params[:id]
    comment.destroy
    flash[:success] = t '.success'
    redirect_to question_path(@question)
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(user: current_user)
  end

  def set_commentable!
    klass = [Question, Answer].detect { |c| params["#{c.name.underscore}_id"] }
    raise ActiveRecord::RecordNotFound if klass.blank?

    @commentable = klass.find(params["#{klass.name.underscore}_id"])
  end

  def set_question
    @question = @commentable.is_a?(Question) ? @commentable : @commentable.question
  end
end
