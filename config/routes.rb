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
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  
  # devise_scope :admin do
  #   root to: "devise/sessions#new"
  # end

  root to: 'home#index'
  

  get 'home', to: 'home#index'
end
