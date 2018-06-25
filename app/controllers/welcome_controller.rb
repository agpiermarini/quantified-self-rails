class WelcomeController < ApplicationController
  def index
    render json: "Successfully deployed to AWS"
  end
end
