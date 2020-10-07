class AddAdminAndNameUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :first_name, :string, null: false, default: ''
    add_column :users, :last_name, :string, null: false, default: ''
    add_column :users, :nickname, :string, null: false, default: ''
    add_column :users, :is_admin, :boolean, default: false
  end
end
