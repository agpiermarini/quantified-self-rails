class Api::V1::MealFoodsController < ApplicationController
  def index
    render json: Meal.find(params[:meal_id]).foods
  end

  def create
    meal = Meal.find(params[:meal_id])
    meal.foods.create!(food_params)
    render json: { message: "Successfully added #{params[:food][:name]} to #{meal.name}" }.to_json , status: 201
  end

  def destroy
    message = "Successfully removed %s from %s" % [Food.find(params[:food_id])[:name], Meal.find(params[:meal_id])[:name]]
    MealFood.find_by(meal_id: params[:meal_id], food_id: params[:food_id]).destroy!
    render json: { message: message}
  end

  private
    def food_params
      params.require(:food).permit(:name, :calories)
    end
end
