class AddColumnKeyToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :git_key, :string, default: nil
  end
end
