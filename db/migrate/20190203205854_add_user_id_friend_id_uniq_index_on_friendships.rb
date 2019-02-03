class AddUserIdFriendIdUniqIndexOnFriendships < ActiveRecord::Migration[5.2]
  def change
    Friendship.find_each do |frs|
      Friendship.where(user_id: frs.user_id, friend_id: frs.friend_id).where.not(id: frs.id).delete_all
    end
    add_index :friendships, [:user_id, :friend_id], unique: true
  end
end
