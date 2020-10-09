# == Schema Information
#
# Table name: skins
#
#  id                  :bigint           not null, primary key
#  description         :string           not null
#  float               :float            not null
#  has_sticker         :boolean          default(FALSE)
#  is_available        :boolean          default(TRUE)
#  is_stattrak         :boolean          default(FALSE)
#  price_csmoney       :float            not null
#  price_paid          :float            not null
#  price_steam         :float            not null
#  sale_price          :float            not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  item_type_id        :bigint           not null
#  skin_exterior_id    :bigint           not null
#  skin_type_id        :bigint           not null
#  transaction_type_id :bigint           not null
#
# Indexes
#
#  index_skins_on_description          (description) UNIQUE
#  index_skins_on_item_type_id         (item_type_id)
#  index_skins_on_skin_exterior_id     (skin_exterior_id)
#  index_skins_on_skin_type_id         (skin_type_id)
#  index_skins_on_transaction_type_id  (transaction_type_id)
#
# Foreign Keys
#
#  fk_rails_...  (item_type_id => item_types.id)
#  fk_rails_...  (skin_exterior_id => skin_exteriors.id)
#  fk_rails_...  (skin_type_id => skin_types.id)
#  fk_rails_...  (transaction_type_id => transaction_types.id)
#
class Skin < ApplicationRecord
  belongs_to :item_type
  belongs_to :skin_type
  belongs_to :skin_exterior
  belongs_to :transaction_type
  before_save :downcase_description
  paginates_per 25

  def downcase_description
    description.downcase!
  end
end
