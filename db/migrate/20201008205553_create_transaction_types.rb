class CreateTransactionTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :transaction_types do |t|
      t.string :description

      t.timestamps
    end
    add_index :transaction_types, :description, unique: true
  end
end
