# frozen_string_literal: true

module Api
  class QuestionsController < ApplicationController
    def index
      @questions = Question.all

      render json: QuestionBlueprint.render(@questions)
    end
  end
end
