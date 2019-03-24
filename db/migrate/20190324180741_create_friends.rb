class CreateFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |t|
      t.references :user, foreign_key: true
      t.belongs_to :friend_user

      t.timestamps
    end
  end
end
