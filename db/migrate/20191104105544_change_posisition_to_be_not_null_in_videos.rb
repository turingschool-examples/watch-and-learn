class ChangePosisitionToBeNotNullInVideos < ActiveRecord::Migration[5.2]
  def up
    change_column :videos, :position, :integer, default: 0, null: false
  end

  def down
    change_column :videos, :position, :integer, default: 0
  end
end
