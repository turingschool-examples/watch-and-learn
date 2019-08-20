class CreateUserCreditials < ActiveRecord::Migration[5.2]
  def change
    create_table :user_creditials do |t|
      t.string :token
      t.references :user, foreign_key: true
    end
  end
end
