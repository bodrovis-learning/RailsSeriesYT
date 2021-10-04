# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :question_tags, dependent: :destroy
  has_many :questions, through: :question_tags

  validates :title, presence: true, uniqueness: true
end
