class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships, id: false do |t|
      t.references :user, foreign_key: true
      t.references :friend, index: true
    end

    add_foreign_key :friendships, :users, column: :friend_id
    add_index :friendships, [:friend_id, :user_id], unique: true
  end
end
