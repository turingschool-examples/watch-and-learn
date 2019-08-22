class AddWebsiteToUserCredentials < ActiveRecord::Migration[5.2]
  def change
    add_column :user_credentials, :website, :string
  end
end
