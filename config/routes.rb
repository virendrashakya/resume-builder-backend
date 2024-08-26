# config/routes.rb

Rails.application.routes.draw do
  # Devise routes
  devise_for :users

  # Custom API Routes
  namespace :api do
    namespace :v1 do
      # Authentication Routes
      post 'auth/signup', to: 'auth#signup'
      post 'auth/login', to: 'auth#login'
      delete 'auth/logout', to: 'auth#logout'

      # User Routes
      get 'users/me', to: 'users#show'
      put 'users/me', to: 'users#update'

      # Resume Routes
      resources :resumes, only: [:create, :show, :update, :destroy] do
        member do
          post 'export'
        end
      end

      # Template Routes
      get 'templates', to: 'templates#index'

      # Payment Routes
      post 'payments', to: 'payments#create'
    end
  end

  # Root route (optional)
  root 'home#index'
end
