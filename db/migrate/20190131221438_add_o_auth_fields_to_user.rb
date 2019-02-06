class AddOAuthFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :github_name, :string
    add_column :users, :github_id, :string
    add_column :users, :github_token, :string
    add_column :users, :github_token_secret, :string
  end
end
