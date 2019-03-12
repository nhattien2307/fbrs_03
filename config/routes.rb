Rails.application.routes.draw do
  root "static_pages#home"

  resources :books
  resources :users

  get "users/new"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
end
