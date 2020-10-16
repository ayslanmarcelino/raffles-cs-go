# frozen_string_literal: true

class CreateItemTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :item_types do |t|
      t.string :description, null: false

      t.timestamps
    end
    add_index :item_types, :description, unique: true
  end
end
