class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations do |t|
      t.string :invitee_handle
      t.string :invitee_name
      t.string :invitee_email

      t.string :inviter_name
      t.timestamps
    end
  end
end
