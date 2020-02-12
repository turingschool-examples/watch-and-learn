class AddIdToFriendUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :friend_users, :friender_id, :integer
    add_column :friend_users, :friendee_id, :integer
  end
end
