require 'csv'

namespace :reset do
  desc "Reset database and import meals"
  task all: :environment do
    MealFood.destroy_all
    Food.destroy_all
    Meal.destroy_all

    Meal.create(name: 'Breakfast')
    Meal.create(name: 'Snacks')
    Meal.create(name: 'Lunch')
    Meal.create(name: 'Dinner')
  end
end
