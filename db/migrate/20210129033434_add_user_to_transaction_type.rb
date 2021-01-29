class AddUserToTransactionType < ActiveRecord::Migration[6.0]
  def change
    add_reference :transaction_types, :user, null: true, foreign_key: true
  end
end
