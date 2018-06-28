require 'csv'

namespace :reset do
  desc "Reset database and import meals"
  task all: :environment do
    MealFood.destroy_all
    Food.destroy_all
    Meal.destroy_all

    ActiveRecord::Base.connection.reset_pk_sequence!(:table_name)
  end
end
