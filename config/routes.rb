Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'static_pages#index'
  resources :games, only: [:index, :new, :create, :show] do
    # can you explain the line below? what is :member? and how does patch work?
    patch 'join', on: :member
  end
  resources :pieces, only: :update
end
