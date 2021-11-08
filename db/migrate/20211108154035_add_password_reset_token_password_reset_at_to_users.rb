# frozen_string_literal: true

class AddPasswordResetTokenPasswordResetAtToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :password_reset_token, :string
    add_index :users, :password_reset_token
    add_column :users, :password_reset_at, :datetime
  end
end
