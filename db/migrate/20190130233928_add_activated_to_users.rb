class AddActivatedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :activated, :boolean, :default => false
  end
end
