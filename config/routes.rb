Rails.application.routes.draw do
  root to: 'home#index'

  resources :product_categories, only: [:show]
end
