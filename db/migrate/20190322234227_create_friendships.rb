class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.timestamps
      t.belongs_to :user
      t.belongs_to :friend
    end
  end
end
