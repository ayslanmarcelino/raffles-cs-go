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
  has_many :skin

  def downcase_description
    description.downcase!
  end

  def skin_exterior_formatted
    humanize_skin_exterior = description.humanize

    humanize_skin_exterior.split.map { |x| x[0].upcase + x[1..-1] }.join(' ')
  end
end
