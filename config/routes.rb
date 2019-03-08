Rails.application.routes.draw do
  root "static_pages#home"

  resources :books
end
