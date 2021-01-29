# == Schema Information
#
# Table name: enterprises
#
#  id              :bigint           not null, primary key
#  description     :string
#  instagram       :string
#  primary_color   :string
#  secondary_color :string
#  twitch          :string
#  whatsapp_group  :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Enterprise < ApplicationRecord
  has_one_attached :logo
  has_one_attached :logo_without_name
  has_one_attached :favicon
  has_many :user
end
