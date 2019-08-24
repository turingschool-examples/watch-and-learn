class AddUidToTokens < ActiveRecord::Migration[5.2]
    def change
      add_column :tokens, :uid, :string
  end
end
