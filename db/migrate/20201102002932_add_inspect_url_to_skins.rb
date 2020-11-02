class AddInspectUrlToSkins < ActiveRecord::Migration[6.0]
  def change
    add_column :skins, :inspect_url, :string
  end
end
