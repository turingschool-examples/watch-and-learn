class CreateFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |t|
      t.belongs_to :user
      t.belongs_to :followed_user
      t.index [:user_id, :followed_user_id], unique: true
    end
  end
end
