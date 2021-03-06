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
  resources :products, only: [:index, :show, :new, :create, :edit, :update] do
    post 'suspend', on: :member
    post 'reactivate', on: :member
    resources :questions
    resources :answers
    resources :purchased_products, only: [:show, :new, :create] do
      post 'refuse', on: :member
      post 'confirm', on: :member
      post 'cancel', on: :member
      post 'conclude', on: :member
    end
  end
  resources :questions 
  resources :purchased_products, only: [] do
    resources :negotiations
    get 'sell', on: :collection
    get 'buy', on: :collection
  end
  get '/search', to: 'home#search'  
end