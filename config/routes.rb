Rails.application.routes.draw do
  root 'theaters#index'
  devise_for :users
  resources :theaters
end
