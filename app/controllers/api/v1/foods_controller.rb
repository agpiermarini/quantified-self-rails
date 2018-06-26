class Api::V1::FoodsController < ApplicationController
  def index
    render json: Food.all
  end

  def show
    render json: Food.find(params[:id])
  end

  def create
    render json: Food.create!(food_params)
  end

  def update
    food = Food.find(params[:id])
    food.name = food_params[:name]
    food.calories = food_params[:calories]
    food.save!
    render json: food
  end

  def destroy
    Food.find(params[:id]).delete
    render status: 204
  end

  private
    def food_params
      params.require(:food).permit(:name, :calories)
    end
end
