# frozen_string_literal: true

class CreateSkinExteriors < ActiveRecord::Migration[6.0]
  def change
    create_table :skin_exteriors do |t|
      t.string :description

      t.timestamps
    end
    add_index :skin_exteriors, :description, unique: true
  end
end
