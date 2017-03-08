Rails.application.routes.draw do
  root 'theaters#index'
  devise_for :users

  resources :theaters do
    resources :reviews, only: [:create, :new, :destroy, :update]
  end

  namespace :admin do
    resources :users, only: [:index]
  end
end
