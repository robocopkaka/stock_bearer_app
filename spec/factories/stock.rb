# frozen_string_literal: true

FactoryBot.define do
  factory :stock do
    name { "#{Faker::Name.gender_neutral_first_name} #{Faker::Name.last_name}" }
    bearer
  end
end
