class AddConnectedToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :connected?, :boolean, default: false 
  end
end
