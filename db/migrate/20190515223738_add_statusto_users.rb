# frozen_string_literal: true

class AddStatustoUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :status, :string, default: 'inactive'
  end
end
