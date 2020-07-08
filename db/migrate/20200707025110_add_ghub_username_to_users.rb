class AddGhubUsernameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :ghub_username, :string
  end
end
