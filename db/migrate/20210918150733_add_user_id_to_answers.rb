# frozen_string_literal: true

class AddUserIdToAnswers < ActiveRecord::Migration[6.1]
  def change
    opts = { null: false, foreign_key: true }
    opts = opts.merge({ default: User.first.id }) if User.all.any?
    add_reference :answers, :user, **opts
  end
end
