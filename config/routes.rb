Rails.application.routes.draw do
  root 'theaters#index'
  devise_for :users

  resources :user do
    resources :theaters
  end

  namespace :admin do
    resources :users, only: [:index, :destroy]
  end

  resources :theaters do
    resources :reviews, only: [:create, :new, :destroy, :update, :edit]
  end

  resources :reviews, only: [:new, :create, :edit, :update, :destroy] do
    resources :votes, only: [:create]
  end

  resources :search, only: [:index]

  namespace :api do
    namespace :v1 do
      resources :theaters, only: [:index]
    end
  end
end
