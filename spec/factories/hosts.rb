# frozen_string_literal: true

FactoryBot.define do
  factory :host do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    mobile { Faker::PhoneNumber.phone_number }
  end
end
