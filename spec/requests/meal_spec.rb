require 'rails_helper'

describe 'Meal Endpoints' do
  describe 'GET /api/v1/meals' do
    it 'returns all database entries for meals' do
      meal_list = create_list(:meal, 3)

      get '/api/v1/meals'

      meals = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(meals.length).to eq(3)
    end
  end
end
