class AddCellPhoneToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :ddi, :string
    add_column :users, :cell_phone, :string
    add_column :users, :is_whatsapp, :boolean, default: false
  end
end
