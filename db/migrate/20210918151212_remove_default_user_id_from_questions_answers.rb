# frozen_string_literal: true

class RemoveDefaultUserIdFromQuestionsAnswers < ActiveRecord::Migration[6.1]
  def up
    change_column_default :questions, :user_id, from: User.first.id, to: nil
    change_column_default :answers, :user_id, from: User.first.id, to: nil
  end

  def down
    change_column_default :questions, :user_id, from: nil, to: User.first.id
    change_column_default :answers, :user_id, from: nil, to: User.first.id
  end
end
