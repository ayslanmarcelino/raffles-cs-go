class AddSteamAccountToSkin < ActiveRecord::Migration[6.0]
  def change
    add_reference :skins, :steam_account, foreign_key: true
  end
end
