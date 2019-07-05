class AddOAuthToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :username, :string
    add_column :users, :email, :string
    add_column :users, :uid, :string
    add_column :users, :secret_token, :string
  end
end
