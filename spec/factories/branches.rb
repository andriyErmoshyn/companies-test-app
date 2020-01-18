# frozen_string_literal: true

FactoryBot.define do
  factory :branch do
    number      { Faker::Number.number(digits: 6) }
    area        { Faker::Address.state }
    company
  end
end
