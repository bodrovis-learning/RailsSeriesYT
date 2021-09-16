# frozen_string_literal: true

class AddGravatarUrlToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :gravatar_url, :string
  end
end
