class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :user, foreigny_key: true
      t.bigint :friend_id, index: true

      t.timestamps
    end
  end
end
