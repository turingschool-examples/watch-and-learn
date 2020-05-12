class RemoveGhTokenFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :git_hub_token, :string
  end
end
