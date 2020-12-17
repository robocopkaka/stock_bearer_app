# frozen_string_literal: true

FactoryBot.define do
  factory :bearer do
    name { "#{Faker::Name.gender_neutral_first_name} #{Faker::Name.last_name}" }
  end
end
