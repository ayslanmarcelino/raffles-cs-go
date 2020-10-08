# frozen_string_literal: true

# == Schema Information
#
# Table name: skin_exteriors
#
#  id          :bigint           not null, primary key
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_skin_exteriors_on_description  (description) UNIQUE
#
class SkinExterior < ApplicationRecord
  validates_uniqueness_of :description
  before_save :downcase_description
  paginates_per 25

  def downcase_description
    description.downcase!
  end
end
