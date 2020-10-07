# == Schema Information
#
# Table name: item_types
#
#  id          :bigint           not null, primary key
#  description :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_item_types_on_description  (description) UNIQUE
#
class ItemType < ApplicationRecord
  validates_uniqueness_of :description
  before_save :downcase_description
  paginates_per 25

  def downcase_description
    description.downcase!
  end
end
