class CreateGithubValues < ActiveRecord::Migration[5.2]
  def change
    create_table :github_values do |t|
      t.string :token
      t.string :uid
      t.string :handle
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
