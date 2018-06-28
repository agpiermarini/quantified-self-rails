class Meal < ApplicationRecord
  validates :name, presence: true

  has_many :meal_foods
  has_many :foods, through: :meal_foods
end
