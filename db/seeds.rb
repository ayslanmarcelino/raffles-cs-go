# frozen_string_literal: true

default_password = 123_456

user = User.create!(email: 'ayslanmarcelino@gmail.com',
             password: default_password,
             password_confirmation: default_password,
             first_name: Faker::Name.first_name,
             last_name: Faker::Name.last_name,
             nickname: Faker::Name.name,
             is_admin: true)

transaction_type = TransactionType.create!(description: 'Rifa')

SteamAccount.create!(description: 'Ayslan',
                     url: 'ayslanmarcelino',
                     steam_id: 76561198345749032,
                     user_id: user.id)
