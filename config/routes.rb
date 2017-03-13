Rails.application.routes.draw do
  root 'theaters#index'
  devise_for :users

  resources :theaters do
    resources :reviews, only: [:create, :new, :destroy, :update, :edit]
  end
  
  namespace :admin do
    resources :users, only: [:index, :destroy]
  end

  namespace :api do
    namespace :v1 do
      resources :theaters, only: [:index]
    end
  end

  resources :user do
    resources :theaters
  end

  resources :search, only: [:index]
end
