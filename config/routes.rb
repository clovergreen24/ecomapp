Rails.application.routes.draw do
  devise_for :admins
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  unauthenticated :admin do
    root to: "devise/sessions#new", as: :unauthenticated_root
  end

  authenticated :admin do
    root to: "home#index", as: :admin_root
  end

  get 'home' => 'home#index'
end
