class AddTokenToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :github_token, :string, default: nil
  end
end
