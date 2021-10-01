# frozen_string_literal: true

class Question < ApplicationRecord
  include Commentable

  has_many :answers, dependent: :destroy
  belongs_to :user
  has_many :question_tags, dependent: :destroy
  has_many :tags, through: :question_tags

  validates :title, presence: true, length: { minimum: 2 }
  validates :body, presence: true, length: { minimum: 2 }

  scope :all_by_tags, ->(tag_ids) do
    questions = includes(:user, :tags, :question_tags)
    questions = questions.joins(:tags).where(tags: tag_ids) if tag_ids
    questions.order(created_at: :desc)
  end
end
