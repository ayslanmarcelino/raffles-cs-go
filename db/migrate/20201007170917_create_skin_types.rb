# frozen_string_literal: true

class CreateSkinTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :skin_types do |t|
      t.string :description
      t.references :item_type, index: {:unique=>true}, null: false, foreign_key: true

      t.timestamps
    end
    add_index :skin_types, :description, unique: true
  end
end
