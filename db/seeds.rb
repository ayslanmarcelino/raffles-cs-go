# frozen_string_literal: true

default_password = 123_456

enterprise = Enterprise.create!(description: 'Pingo rifas',
                                primary_color: '#1f1f1f',
                                secondary_color: '#e5e1e1')

user = User.create!(email: 'superadmin@gmail.com',
                    password: default_password,
                    password_confirmation: default_password,
                    first_name: Faker::Name.first_name,
                    last_name: Faker::Name.last_name,
                    nickname: Faker::Name.name,
                    is_admin: true,
                    is_owner: true,
                    is_super_admin: true,
                    enterprise_id: enterprise.id)

TransactionType.create!(description: 'Rifa')

SteamAccount.create!(description: 'Ayslan',
                     url: 'ayslanmarcelino',
                     steam_id: 76561198345749032,
                     user_id: user.id)
