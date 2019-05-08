class AddGithubTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :github_token, :text
    add_column :users, :username, :string
  end
end
