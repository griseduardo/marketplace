Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :product_categories, only: [:show] do
    get 'search', on: :member
  end
  resources :product_subcategories, only: [:show] do
    get 'search', on: :member
  end
  resources :profiles, only: [:index, :show, :new, :create, :edit, :update] do
    get 'search', on: :member
  end
  resources :products, only: [:index, :show, :new, :create] do
    resources :questions
    resources :answers
  end
  resources :questions 
  get '/search', to: 'home#search'  
end