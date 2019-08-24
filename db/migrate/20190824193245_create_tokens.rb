class CreateTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :tokens do |t|
      t.string :provider
      t.string :token
      t.references :user, foreign_key: true
    end
  end
end
