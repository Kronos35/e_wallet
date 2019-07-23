Rails.application.routes.draw do
  devise_for :users

  root "landing#home"
  resources :users, only: [:show, :edit, :update]
end
