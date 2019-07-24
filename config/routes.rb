Rails.application.routes.draw do
  devise_for :users

  root "landing#home"
  resources :users, only: %i(show edit update)
  resources :credit_cards, except: [:show]
end
