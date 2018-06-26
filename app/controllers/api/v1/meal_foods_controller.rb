class Api::V1::MealFoodsController < ApplicationController
  def index
    render json: Meal.find(params[:meal_id]).foods
  end
end
