require 'rails_helper'

describe MealFood, type: :model do
  describe 'relationships' do
    it {should belong_to :meal}
    it {should belong_to :food}
  end
end
