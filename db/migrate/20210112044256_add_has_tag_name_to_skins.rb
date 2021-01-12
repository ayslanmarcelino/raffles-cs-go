class AddHasTagNameToSkins < ActiveRecord::Migration[6.0]
  def change
    add_column :skins, :has_name_tag, :boolean, default: false
    add_column :skins, :description_name_tag, :string, default: ''
  end
end
