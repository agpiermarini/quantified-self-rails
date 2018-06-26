require 'rails_helper'

describe 'Food Endpoints' do
  describe 'GET /api/v1/foods' do
    it 'returns all database entries for foods' do
      food_list = create_list(:food, 3)

      get '/api/v1/foods'

      foods = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(foods.length).to eq(3)
      expect(foods.first[:name]).to eq(food_list.first.name)
      expect(foods.first[:calories]).to eq(food_list.first.calories)
      expect(foods.second[:name]).to eq(food_list.second.name)
      expect(foods.second[:calories]).to eq(food_list.second.calories)
      expect(foods.last[:name]).to eq(food_list.last.name)
      expect(foods.last[:calories]).to eq(food_list.last.calories)
    end
  end

  describe 'GET /api/v1/foods/:id' do
    it 'returns record for food object corresponding to the provided id' do
      food_item = create(:food)

      get "/api/v1/foods/#{food_item.id}"

      food = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(food[:name]).to eq(food_item.name)
      expect(food[:calories]).to eq(food_item.calories)
    end

    it 'returns a 404 if there is no food object corresponding to the provided id' do
      get "/api/v1/foods/1"

      expect(response).to_not be_success
      expect(response.status).to eq(404)
    end
  end
end
