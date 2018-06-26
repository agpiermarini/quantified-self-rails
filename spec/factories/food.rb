FactoryBot.define do
  factory :food do
    name Faker::Food.ingredient
    calories { rand(1..500) }
  end
end
