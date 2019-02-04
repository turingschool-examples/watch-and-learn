class AddStatusToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :email_activation_status, :integer, default: 0
  end
end
