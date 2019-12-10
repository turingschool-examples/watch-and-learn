class AddHandleToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :handle, :string
  end
end
