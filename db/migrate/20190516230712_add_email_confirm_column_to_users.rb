class AddEmailConfirmColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :email_confirmed, :integer, default: 0
    add_column :users, :confirm_token, :string
  end
end
