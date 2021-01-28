# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  cell_phone             :string
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  ddi                    :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           default(""), not null
#  is_admin               :boolean          default(FALSE)
#  is_owner               :boolean          default(FALSE)
#  is_super_admin         :boolean          default(FALSE)
#  is_whatsapp            :boolean          default(FALSE)
#  last_name              :string           default(""), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  nickname               :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  enterprise_id          :bigint
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_enterprise_id         (enterprise_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (enterprise_id => enterprises.id)
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :timeoutable
  paginates_per 25
  belongs_to :enterprise
  has_many :steam_account
  has_many :transactions

  def full_name
    "#{first_name} #{last_name}"
  end
end
