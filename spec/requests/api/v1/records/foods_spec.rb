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

  describe 'POST /api/v1/foods' do
    it 'creates new food record with proper parameters and returns food object as json' do
      food_name = 'orange'
      food_calories = 200

      post '/api/v1/foods', params: { food: {name: food_name, calories: food_calories } }

      food = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(Food.all.last.name).to eq(food_name)
      expect(Food.all.last.calories).to eq(food_calories)
      expect(food[:name]).to eq(food_name)
      expect(food[:calories]).to eq(food_calories)
    end

    it 'returns a 404 if name is missing' do
      post '/api/v1/foods', params: { food: {calories: 400 } }

      expect(response).to_not be_success
      expect(response.status).to eq(404)
    end

    it 'returns a 404 if calories is missing' do
      post '/api/v1/foods', params: { food: {name: 'orange' } }

      expect(response).to_not be_success
      expect(response.status).to eq(404)
    end
  end

  describe 'PATCH /api/v1/foods/:id' do
    it 'updates object if proper parameters are present, and returns food object as json' do
      food_item = create(:food, name: 'apple', calories: 100)
      new_name = 'orange'
      new_calories = 200

      patch "/api/v1/foods/#{food_item.id}", params: { food: {name: new_name, calories: new_calories } }

      food = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(food[:name]).to eq(new_name)
      expect(food[:calories]).to eq(new_calories)
    end

    it 'returns a 404 if name is missing' do
      food_item = create(:food, name: 'apple', calories: 100)
      patch "/api/v1/foods/#{food_item.id}", params: { food: {calories: 400 } }

      expect(response).to_not be_success
      expect(response.status).to eq(404)
      expect(Food.last.name).to eq('apple')
      expect(Food.last.calories).to eq(100)
    end

    it 'returns a 404 if calories is missing' do
      food_item = create(:food, name: 'apple', calories: 100)
      patch "/api/v1/foods/#{food_item.id}", params: { food: {name: 'orange' } }

      expect(response).to_not be_success
      expect(response.status).to eq(404)
      expect(Food.last.name).to eq('apple')
      expect(Food.last.calories).to eq(100)
    end
  end

  describe 'DELETE /api/v1/foods/:id' do
    it 'deletes existing object and returns a 204' do
      food_item = create(:food, name: 'apple', calories: 100)

      delete "/api/v1/foods/#{food_item.id}"

      expect(response).to be_success
      expect(response.status).to eq(204)
    end

    it 'returns a 404 if object does not exist' do
      delete "/api/v1/foods/1"

      expect(response).to_not be_success
      expect(response.status).to eq(404)
    end
  end
end
