class AddIgnoreFinancialToSkins < ActiveRecord::Migration[6.0]
  def change
    add_column :skins, :ignore_financial, :boolean, default: false
  end
end
