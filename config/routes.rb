Rails.application.routes.draw do
  root 'theaters#index'
  devise_for :users

  resources :theaters do
    resources :reviews, only: [:create, :new, :destroy, :update, :edit]
  end

  resources :reviews, only: [] do
    resources :votes, only: [:create, :update]
  end

  namespace :admin do
    resources :users, only: [:index, :destroy]
  end

  resources :user do
    resources :theaters
  end
end
