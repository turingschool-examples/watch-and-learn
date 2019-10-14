# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string  :email, index: true
      t.string  :first_name
      t.string  :last_name
      t.string  :password_digest
      t.integer :role, default: 0
      t.string  :github_token, default: nil
      t.bigint  :github_username, default: nil
      t.timestamps
    end
  end
end
