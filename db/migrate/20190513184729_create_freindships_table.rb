class CreateFreindshipsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :freindships do |t|
      t.belongs_to :user
      t.belongs_to :friended_user
      t.index [:user_id, :friended_user_id], unique: true
      t.timestamps
    end
  end
end
