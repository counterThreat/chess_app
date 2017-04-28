Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'static_pages#index'
  resources :pieces
  resources :games
  # resources :pieces, only: [:show, :update]
  # resources :games, only: [:index, :new, :create, :show, :edit, :update] # do
     # resources :pieces, only: [:show, :update]
   # end
    # resources :pieces, only: [:show, :update] #:create, :index
end
