class AddGhTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :git_hub_token, :string
  end
end
