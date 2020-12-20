class CreateSteamAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :steam_accounts do |t|
      t.string :description
      t.bigint :steam_id, null: false
      t.string :url, null: false, unique: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :steam_accounts, :steam_id, unique: true
    add_index :steam_accounts, :url, unique: true
  end
end
