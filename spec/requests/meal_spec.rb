require 'rails_helper'

describe 'Meal Endpoints' do
  describe 'GET /api/v1/meals' do
    it 'returns all database entries for meals' do
      meal_list = create_list(:meal, 3)

      get '/api/v1/meals'

      meals = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(meals.length).to eq(3)
      expect(meals[0][:name]).to eq(meal_list[0].name)
      expect(meals[1][:name]).to eq(meal_list[1].name)
      expect(meals[2][:name]).to eq(meal_list[2].name)
      expect(meals[2][:foods]).to be_an(Array)
      expect(meals[2][:foods].length).to be(3)
    end
  end

  describe 'GET /api/v1/meals/:meal_id/foods' do
    it 'returns all database entries for foods corresponding to an existing meal id' do
      meal = create(:meal)

      get "/api/v1/meals/#{meal.id}/foods"

      foods = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(foods[0][:name]).to eq(meal.foods[0].name)
      expect(foods[0][:calories]).to eq(meal.foods[0].calories)
      expect(foods[1][:name]).to eq(meal.foods[1].name)
      expect(foods[1][:calories]).to eq(meal.foods[1].calories)
      expect(foods[2][:name]).to eq(meal.foods[2].name)
      expect(foods[2][:calories]).to eq(meal.foods[2].calories)
    end

    it 'returns a 404 if unsuccessful' do

      get "/api/v1/meals/5/foods"

      expect(response).to_not be_success
      expect(response.status).to be(404)
    end
  end
end
