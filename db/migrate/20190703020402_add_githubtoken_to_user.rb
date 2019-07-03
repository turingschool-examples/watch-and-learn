class AddGithubtokenToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :github_token, :text
  end
end
