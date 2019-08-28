class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.bigint 'user_id'
      t.bigint 'friend_id'
      t.index ["user_id"], name: "index_friendships_on_user_id"
      t.timestamps
    end
  end
end
