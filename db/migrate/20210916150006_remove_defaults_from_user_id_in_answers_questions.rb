# frozen_string_literal: true

class RemoveDefaultsFromUserIdInAnswersQuestions < ActiveRecord::Migration[6.1]
  def change
    change_column_default :questions, :user_id, from: User.first.id, to: nil
    change_column_default :answers, :user_i, from: User.first.id, to: nil
  end
end
