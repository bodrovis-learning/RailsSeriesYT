# frozen_string_literal: true

class AddUniqueConstraintToUsersOnTitle < ActiveRecord::Migration[6.1]
  def change
    add_index :tags, :title, unique: true
  end
end
