class CreateSkins < ActiveRecord::Migration[6.0]
  def change
    create_table :skins do |t|
      t.bigint :id_steam, null: false
      t.string :description, null: false
      t.string :exterior
      t.string :image_skin
      t.float :float, null: false
      t.float :price_steam, null: false
      t.float :price_csmoney, default: 0
      t.float :price_paid, default: 0
      t.float :sale_price, default: 0
      t.boolean :is_stattrak, default: false
      t.boolean :has_sticker, default: false
      t.boolean :is_available, default: true
      # t.references :item_type, null: false, foreign_key: true
      # t.references :skin_type, null: false, foreign_key: true
      # t.references :skin_exterior, null: false, foreign_key: true
      # t.references :transaction_type, null: true, foreign_key: true

      t.timestamps
    end
    add_index :skins, :id_steam, unique: true
  end
end
