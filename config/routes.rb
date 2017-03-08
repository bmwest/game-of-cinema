Rails.application.routes.draw do
  root 'theaters#index'
  devise_for :users
  resources :theaters

  namespace :admin do
    resources :users, only: [:index]
  end

end
