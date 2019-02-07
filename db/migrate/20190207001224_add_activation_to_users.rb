class AddActivationToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :activated, :boolean, default: false
    add_column :users, :activation_token, :string
  end
end
