class CreateEnterprises < ActiveRecord::Migration[6.0]
  def change
    create_table :enterprises do |t|
      t.string :description
      t.string :primary_color
      t.string :secondary_color
      t.string :instagram
      t.string :twitch
      t.string :whatsapp_group

      t.timestamps
    end
  end
end
