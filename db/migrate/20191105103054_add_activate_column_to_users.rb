class AddActivateColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :activate, :string
  end
end
