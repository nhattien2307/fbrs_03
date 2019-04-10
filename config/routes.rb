Rails.application.routes.draw do
  root "static_pages#home"
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}

  namespace :admin do
    resources :suggests, only: %i(update index)
  end
  resources :relationships, only: %i(create destroy)
  resources :suggests
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

  resources :favorites
  resources :activities

  get "/findfavorite", to: "books#findfavorite"
  get "users/new"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
