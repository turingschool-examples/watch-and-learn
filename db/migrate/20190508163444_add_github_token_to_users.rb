# frozen_string_literal: true

# this migration addes the github token to the users table
class AddGithubTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :github_token, :text
    add_column :users, :username, :string
  end
end
