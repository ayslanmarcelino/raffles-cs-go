# == Schema Information
#
# Table name: skins
#
#  id            :bigint           not null, primary key
#  description   :string           not null
#  exterior      :string
#  float         :float            not null
#  has_sticker   :boolean          default(FALSE)
#  id_steam      :bigint           not null
#  image_skin    :string
#  is_available  :boolean          default(TRUE)
#  is_stattrak   :boolean          default(FALSE)
#  price_csmoney :float            default(0.0)
#  price_paid    :float            default(0.0)
#  price_steam   :float            not null
#  sale_price    :float            default(0.0)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_skins_on_id_steam  (id_steam) UNIQUE
#
class Skin < ApplicationRecord
  # before_save :downcase_description
  # paginates_per 25
  # has_one_attached :image_skin

  # def downcase_description
  #   description.downcase!
  # end
end
