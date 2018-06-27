class Api::V1::MealFoodsController < ApplicationController
  def index
    render json: Meal.find(params[:meal_id]).foods
  end

  def create
    meal = Meal.find(params[:meal_id])
    meal.foods.create!(food_params)
    require 'pry'; binding.pry
    render json: { message: "Successfully added #{params[:food][:name]} to #{meal.name}" }.to_json , status: 201
  end

  private
    def food_params
      params.require(:food).permit(:name, :calories)
    end
end
