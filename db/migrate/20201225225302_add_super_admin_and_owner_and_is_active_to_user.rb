class AddSuperAdminAndOwnerAndIsActiveToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :is_super_admin, :boolean, default: false
    add_column :users, :is_owner, :boolean, default: false
    add_column :users, :is_active, :boolean, default: true
  end
end
