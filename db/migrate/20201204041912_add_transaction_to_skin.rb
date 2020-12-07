class AddTransactionToSkin < ActiveRecord::Migration[6.0]
  def change
    add_reference :skins, :transaction, null: true, foreign_key: true
  end
end
