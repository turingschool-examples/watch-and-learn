class AddsTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :token, :string, default: nil
  end
end
