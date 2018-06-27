FactoryBot.define do
  factory :meal do
    name Faker::Food.dish
    foods { create_list :food, 3 }
  end
end
