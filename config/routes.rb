Rails.application.routes.draw do
  devise_for :users

  resources :restaurants

  resources :locations

  root "locations#index"
end
