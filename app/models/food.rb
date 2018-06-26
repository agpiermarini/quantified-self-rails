class Food < ApplicationRecord
  validates :name, presence: true
  validates :calories, presence: true
end
