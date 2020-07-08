class AddStatusToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :email_confirmation, :boolean, :default => false
  end
end
