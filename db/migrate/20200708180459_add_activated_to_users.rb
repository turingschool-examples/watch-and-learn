class AddActivatedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :activated, :boolean
  end
end
