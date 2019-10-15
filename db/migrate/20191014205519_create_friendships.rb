class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.timestamps
      t.belongs_to :user
      t.belongs_to :friendship_user
      t.index [:user_id, :friendship_user_id], unique: true
    end
  end
end
