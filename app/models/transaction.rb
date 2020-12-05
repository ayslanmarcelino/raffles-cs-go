# == Schema Information
#
# Table name: transactions
#
#  id                  :bigint           not null, primary key
#  description         :string
#  price               :float
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  transaction_type_id :bigint           not null
#
# Indexes
#
#  index_transactions_on_transaction_type_id  (transaction_type_id)
#
# Foreign Keys
#
#  fk_rails_...  (transaction_type_id => transaction_types.id)
#
class Transaction < ApplicationRecord
  validates_uniqueness_of :description
  before_save :downcase_description
  belongs_to :transaction_type
  has_many :skins

  def downcase_description
    description.downcase!
  end

  def skins_descriptions
    order_descriptions = skins.order(:description)
    order_descriptions.map(&:description)
  end

  def skins_price_steam
    skins.sum(&:price_steam)
  end

  def skins_price_paid
    skins.sum(&:price_paid)
  end
end
