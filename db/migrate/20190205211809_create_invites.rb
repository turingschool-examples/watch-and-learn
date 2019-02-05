class CreateInvites < ActiveRecord::Migration[5.2]
  def change
    create_table :invites do |t|
      t.string :github_handle
      t.string :github_email

      t.timestamps
    end
  end
end
