class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.belongs_to :user
      t.belongs_to :friend
      t.index [:user_id, :friend_id], unique: true
      t.timestamps
    end
  end
end
