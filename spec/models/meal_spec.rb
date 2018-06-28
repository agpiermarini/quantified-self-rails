require 'rails_helper'

describe Meal, type: :model do
  describe 'attributes' do
    it {should validate_presence_of :name}
  end

  describe 'relationships' do
    it {should have_many :foods}
    it {should have_many :meal_foods}
  end
end
