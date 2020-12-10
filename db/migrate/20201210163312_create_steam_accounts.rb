class CreateSteamAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :steam_accounts do |t|
      t.string :description
      t.bigint :steam_id, null: false
      t.string :url, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
