Rails.application.routes.draw do
  root "static_pages#home"

  resources :relationships, only: %i(create destroy)
  resources :books do
    resources :reviews do
      resources :comments
    end
  end
  resources :users do
    member do
      get :following, :followers
    end
  end

  get "users/new"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
