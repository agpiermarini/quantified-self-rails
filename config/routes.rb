Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  namespace :api do
    namespace :v1 do
      resources :foods
      resources :meals, only: [:index] do
        get 'foods',          to: 'meal_foods#index'
        get 'foods/:food_id', to: 'meal_foods#show'
      end
    end
  end
end
