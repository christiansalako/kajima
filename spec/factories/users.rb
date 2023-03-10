# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    mobile { Faker::PhoneNumber.phone_number }
    password { 'password' }
    password_confirmation { 'password' }
    approved { true }

    trait :unapproved do
      approved { false }
    end
  end
end
