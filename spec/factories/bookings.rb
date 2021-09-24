# frozen_string_literal: true

FactoryBot.define do
  factory :booking do
    association :user
    start_time { 1.day.from_now.change(hour: 12) }
    end_time { 1.day.from_now.change(hour: 14) }

    trait :with_host do
      association :host
    end

    trait :provisional do
      state { 'provisional' }
    end

    trait :confirmed do
      state { 'confirmed' }
      confirmed_at { Time.current }
      association :confirmed_by, factory: :user
    end

    trait :cancelled do
      state { 'cancelled' }
    end
  end
end
