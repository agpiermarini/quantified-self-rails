class Api::V1::FoodsController < ApplicationController
  def index
    render json: Food.all
  end

  def show
    render json: Food.find(params[:id])
  end

  def create
    food = Food.create!(food_params)
    render json: food
  end

  def update
    food = Food.update(food_params).first
    render json: food
  end

  private
    def food_params
      params.require(:food).permit(:name, :calories)
    end
end
