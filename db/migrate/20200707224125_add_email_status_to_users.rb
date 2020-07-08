class AddEmailStatusToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :email_status, :boolean, default: false
  end
end
