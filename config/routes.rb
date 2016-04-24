Rails.application.routes.draw do
  devise_for :users

  resources :restaurants

  root "home#index"
end
