# frozen_string_literal: true

class AddGithubTokenToUsersTable < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :github_token, :string
  end
end
