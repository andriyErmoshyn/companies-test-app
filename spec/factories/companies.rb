# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    name         { Faker::Company.name }
    description  { Faker::Lorem.sentences(number: 1) }
    address      { Faker::Address.full_address }

    trait :with_branches do
      after(:create) { |company| create_list(:branch, 3, company: company) }
    end
  end
end
