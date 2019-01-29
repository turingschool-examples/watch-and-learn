class AddGithubKeyToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :github_key, :string
  end
end
