# == Schema Information
#
# Table name: steam_accounts
#
#  id          :bigint           not null, primary key
#  description :string
#  url         :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  steam_id    :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_steam_accounts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class SteamAccount < ApplicationRecord
  belongs_to :user

  def account_formatted
    "#{url} | #{description}"
  end
end
