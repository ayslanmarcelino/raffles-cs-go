# frozen_string_literal: true

# == Schema Information
#
# Table name: skin_types
#
#  id           :bigint           not null, primary key
#  description  :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  item_type_id :bigint           not null
#
# Indexes
#
#  index_skin_types_on_description   (description) UNIQUE
#  index_skin_types_on_item_type_id  (item_type_id)
#
# Foreign Keys
#
#  fk_rails_...  (item_type_id => item_types.id)
#
class SkinType < ApplicationRecord
  belongs_to :item_type
  validates_uniqueness_of :description
  before_save :downcase_description
  paginates_per 25

  def downcase_description
    description.downcase!
  end
end
