class AddHtmlUrlToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :html_url, :string
  end
end
