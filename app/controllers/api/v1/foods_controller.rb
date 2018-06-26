class Api::V1::FoodsController < ApplicationController
  def index
    render json: Food.all
  end

  def show
    food = Food.find(params[:id])
    if food
      render json: food
    else
      render status: :not_found
    end
  end
end
