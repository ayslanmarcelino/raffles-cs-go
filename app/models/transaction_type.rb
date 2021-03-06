# == Schema Information
#
# Table name: transaction_types
#
#  id          :bigint           not null, primary key
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_transaction_types_on_description  (description) UNIQUE
#
class TransactionType < ApplicationRecord
  validates_uniqueness_of :description
  before_save :downcase_description
  paginates_per 25
  has_many :skin

  def downcase_description
    description.downcase!
  end

  def transaction_type_formatted
    humanize_transaction_type = description.humanize

    humanize_transaction_type.split.map { |x| x[0].upcase + x[1..-1] }.join(' ')
  end
end
