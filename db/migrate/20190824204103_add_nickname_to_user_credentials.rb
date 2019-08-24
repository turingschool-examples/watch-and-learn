class AddNicknameToUserCredentials < ActiveRecord::Migration[5.2]
  def change
    add_column :user_credentials, :nickname, :string
  end
end
