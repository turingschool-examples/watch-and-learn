class RemoveIdsFromFriendUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :friend_users, :friend_id, :integer
    remove_column :friend_users, :user_id, :integer
  end
end
