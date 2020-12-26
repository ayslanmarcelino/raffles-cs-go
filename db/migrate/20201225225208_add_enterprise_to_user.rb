class AddEnterpriseToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :enterprise, foreign_key: true
  end
end
