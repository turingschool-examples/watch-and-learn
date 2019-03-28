# frozen_string_literal: true

class AddActivationTokenAndActivatedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :activation_token, :string
    add_column :users, :activated, :boolean, default: false
  end
end
