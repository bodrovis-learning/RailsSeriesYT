class QuestionBlueprint < Blueprinter::Base
  extend ActionView::Helpers::TextHelper

  identifier :id

  field :body do |question, options|
    truncate question.body, length: 150, omission: options[:omission]
  end
end