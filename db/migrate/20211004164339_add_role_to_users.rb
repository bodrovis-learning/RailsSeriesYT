# frozen_string_literal: true

class AddRoleToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :role, :integer, default: 0, null: false
    add_index :users, :role
  end
end
