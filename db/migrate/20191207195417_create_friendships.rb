class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.bigint :user_id
      t.bigint :friend_id
    end
  end
end
