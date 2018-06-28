require 'csv'

namespace :reset do
  desc "Reset database and import meals"
  task all: :environment do
    MealFood.destroy_all
    Food.destroy_all
    Meal.destroy_all


    %w(Breakfast Lunch Snacks Dinner).each do | meal |
      Meal.create(name: meal)
    end
  end
end
