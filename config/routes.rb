Rails.application.routes.draw do
  root "static_pages#home"

  resources :books do
    resources :reviews
  end
  resources :users

  get "users/new"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
