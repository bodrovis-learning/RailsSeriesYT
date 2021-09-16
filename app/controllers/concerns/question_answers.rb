# frozen_string_literal: true

module QuestionAnswers
  extend ActiveSupport::Concern

  included do
    def load_question_answers(rerender: false)
      @question = @question.decorate
      @pagy, @answers = pagy @question.answers.includes(:user).order created_at: :desc
      @answers = @answers.decorate
      @answer ||= @question.answers.build
      render('questions/show') if rerender
    end
  end
end
