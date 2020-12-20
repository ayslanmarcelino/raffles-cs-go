class AddTypeSkinAndTypeWeaponToSkins < ActiveRecord::Migration[6.0]
  def change
    add_column :skins, :type_skin, :string
    add_column :skins, :type_weapon, :string
  end
end
