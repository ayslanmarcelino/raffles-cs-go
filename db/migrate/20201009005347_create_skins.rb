class CreateSkins < ActiveRecord::Migration[6.0]
  def change
    create_table :skins do |t|
      t.string :description, null: false
      t.float :float, null: false
      t.float :price_steam, null: false
      t.float :price_csmoney, null: false
      t.float :price_paid, null: false
      t.float :sale_price, null: false
      t.boolean :is_stattrak, default: false
      t.boolean :has_sticker, default: false
      t.boolean :is_available, default: true
      t.references :item_type, null: false, foreign_key: true
      t.references :skin_type, null: false, foreign_key: true
      t.references :skin_exterior, null: false, foreign_key: true
      t.references :transaction_type, null: false, foreign_key: true

      t.timestamps
    end
    add_index :skins, :description, unique: true
  end
end
