class ChangeDefaultForUserActivated < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :activated, false
  end
end
