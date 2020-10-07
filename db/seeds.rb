# frozen_string_literal: true

default_password = 123_456

User.create!(email: 'ayslanmarcelino@gmail.com',
             password: default_password,
             password_confirmation: default_password,
             first_name: Faker::Name.first_name,
             last_name: Faker::Name.last_name,
             nickname: Faker::Name.name,
             is_admin: true)

User.create!(email: Faker::Internet.email,
             password: default_password,
             password_confirmation: default_password,
             first_name: Faker::Name.first_name,
             last_name: Faker::Name.last_name,
             nickname: Faker::Name.name,
             is_admin: false)
