Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :product_categories, only: [:show]
  resources :profiles, only: [:index, :show, :new, :create, :edit, :update]
end