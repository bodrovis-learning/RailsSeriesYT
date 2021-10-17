# frozen_string_literal: true

class Answer < ApplicationRecord
  include Authorship
  include Commentable

  belongs_to :question
  belongs_to :user

  validates :body, presence: true, length: { minimum: 5 }
end
