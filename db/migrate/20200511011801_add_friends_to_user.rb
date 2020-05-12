class AddFriendsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :friends, :string, array: true, :default => []
  end
end
