require 'rails_helper'

describe 'Food Endpoints' do
  describe '/api/v1/foods' do
    it 'returns all database entries for foods' do
      create_list(:food, 5)

      get '/api/v1/foods'

      foods = JSON.parse(response.body)

      expect(response).to be_success
      expect(foods.length).to eq(5)
    end
  end
end
