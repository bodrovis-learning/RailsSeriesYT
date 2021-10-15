class QuestionBlueprint < Blueprinter::Base
  extend ActionView::Helpers::TextHelper

  identifier :id

  field :body do |question, _options|
    truncate question.body, length: 150
  end
end