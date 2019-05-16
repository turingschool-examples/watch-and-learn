class AddGithubNameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :github_name, :string, default: nil
  end
end
