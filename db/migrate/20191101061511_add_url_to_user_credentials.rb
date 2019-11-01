class AddUrlToUserCredentials < ActiveRecord::Migration[5.2]
  def change
    add_column :user_credentials, :url, :string
  end
end
