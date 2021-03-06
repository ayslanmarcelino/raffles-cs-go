# == Schema Information
#
# Table name: skins
#
#  id                   :bigint           not null, primary key
#  description          :string           not null
#  description_color    :string           not null
#  description_name_tag :string           default("")
#  expiration_date      :datetime
#  exterior             :string
#  first_price_steam    :float            default(0.0)
#  float                :float            not null
#  has_name_tag         :boolean          default(FALSE)
#  has_sticker          :boolean          default(FALSE)
#  id_steam             :bigint           not null
#  ignore_financial     :boolean          default(FALSE)
#  image_skin           :string
#  image_sticker        :text             default([]), is an Array
#  inspect_url          :string
#  is_available         :boolean          default(TRUE)
#  is_stattrak          :boolean          default(FALSE)
#  name_sticker         :text             default([]), is an Array
#  price_csmoney        :float            default(0.0)
#  price_paid           :float            default(0.0)
#  price_steam          :float            default(0.0)
#  sale_price           :float            default(0.0)
#  type_skin            :string
#  type_weapon          :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  steam_account_id     :bigint
#  transaction_id       :bigint
#
# Indexes
#
#  index_skins_on_id_steam          (id_steam) UNIQUE
#  index_skins_on_steam_account_id  (steam_account_id)
#  index_skins_on_transaction_id    (transaction_id)
#
# Foreign Keys
#
#  fk_rails_...  (steam_account_id => steam_accounts.id)
#  fk_rails_...  (transaction_id => transactions.id)
#
class Skin < ApplicationRecord
  belongs_to :steam_account
  paginates_per 20

  def status_skins
    return 'StatTrak' if is_stattrak
    return 'Tem adesivo' if has_sticker
  end
end
