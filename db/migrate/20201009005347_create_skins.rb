class CreateSkins < ActiveRecord::Migration[6.0]
  def change
    create_table :skins do |t|
      t.bigint :id_steam, null: false
      t.string :description, null: false
      t.string :description_color, null: false
      t.string :exterior
      t.string :image_skin
      t.float :float, null: false
      t.float :price_steam, default: 0
      t.float :first_price_steam, default: 0
      t.float :price_csmoney, default: 0
      t.float :price_paid, default: 0
      t.float :sale_price, default: 0
      t.boolean :is_stattrak, default: false
      t.boolean :has_sticker, default: false
      t.text :name_sticker, array: true, default: []
      t.text :image_sticker, array: true, default: []
      t.boolean :is_available, default: true
      t.datetime :expiration_date

      t.timestamps
    end
    add_index :skins, :id_steam, unique: true
  end
end
