Rails.application.routes.draw do
  namespace :admin do
    resources :categories
    resources :orders
    resources :products do
      resources :stocks
    end
  end
  devise_for :admins

  namespace :api do
    namespace :v1 do
      resources :categories
      resources :orders
      resources :products
      resources :stocks
      resources :csrf_tokens, only: [:index]
    end
  end

  get '/api/v1/products/by_category/:id', to: 'api/v1/products#by_category'
  get '/api/v1/products/:id', to: 'api/v1/products#show'
  get '/api/v1/stocks/available_stock/:stocklist', to: 'api/v1/stocks#availableStock'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  
  # devise_scope :admin do
  #   root to: "devise/sessions#new"
  # end

  root to: 'home#index'
  

  get 'home', to: 'home#index'
end
