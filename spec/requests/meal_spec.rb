require 'rails_helper'

describe 'Meal Endpoints' do
  describe 'GET /api/v1/meals' do
    it 'returns all database entries for meals' do
      meal_list = create_list(:meal, 3)

      get '/api/v1/meals'

      meals = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
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

      expect(response).to be_successful
      expect(foods[0][:name]).to eq(meal.foods[0].name)
      expect(foods[0][:calories]).to eq(meal.foods[0].calories)
      expect(foods[1][:name]).to eq(meal.foods[1].name)
      expect(foods[1][:calories]).to eq(meal.foods[1].calories)
      expect(foods[2][:name]).to eq(meal.foods[2].name)
      expect(foods[2][:calories]).to eq(meal.foods[2].calories)
    end

    it 'returns a 404 if unsuccessful' do

      get "/api/v1/meals/5/foods"

      expect(response).to_not be_successful
      expect(response.status).to be(404)
    end
  end

  describe 'POST /api/v1/meals/:meal_id/foods' do
    it 'creates a new record in the meal foods table and responds with a message and 201 status' do
      meal = create(:meal)
      food_name = 'orange'
      food_calories = 200

      post "/api/v1/meals/#{meal.id}/foods", params: { food: {name: food_name, calories: food_calories } }

      msg = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(msg[:message]).to eq("Successfully added #{food_name} to #{meal.name}")
      expect(MealFood.last.meal_id).to eq(meal.id)
      expect(MealFood.last.food_id).to eq(Food.last.id)
    end

    it 'returns a 404 if name is missing' do
      meal = create(:meal)
      food_name = 'orange'
      food_calories = 200

      post "/api/v1/meals/#{meal.id}/foods", params: { food: {calories: food_calories } }

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
    end

    it 'returns a 404 if calories is missing' do
      meal = create(:meal)
      food_name = 'orange'
      food_calories = 200

      post "/api/v1/meals/#{meal.id}/foods", params: { food: {name: food_name} }

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
    end
  end

  describe 'DELETE /api/v1/meals/:meal_id/foods/:food_id' do
    it 'deletes a meal_food record corresponding to the meal and food id' do
      meal = create(:meal)
      food = create(:food, name: 'wild boar')
      meal.foods << food

      delete "/api/v1/meals/#{meal.id}/foods/#{meal.foods.last.id}"

      message = JSON.parse(response.body, symbolize_names: true)[:message]

      expect(response).to be_successful
      expect(message).to eq("Successfully removed #{food.name} from #{meal.name}")
      expect(MealFood.find_by(meal_id: meal.id, food_id: food.id)).to eq(nil)
    end

    it 'returns a 404 if food is not associated with meal (bad meal id)' do
      meal = create(:meal)
      food = create(:food, name: 'wild boar')
      meal.foods << food

      delete "/api/v1/meals/100/foods/#{meal.foods.last.id}"

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(MealFood.find_by(meal_id: meal.id, food_id: food.id)).to_not eq(nil)
    end

    it 'returns a 404 if food is not associated with meal (bad food id)' do
      meal = create(:meal)
      food = create(:food, name: 'wild boar')
      meal.foods << food

      delete "/api/v1/meals/1/foods/100"

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(MealFood.find_by(meal_id: meal.id, food_id: food.id)).to_not eq(nil)
    end
  end
end
