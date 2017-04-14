Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'static_pages#index'
  resources :games, only: [:create, :show, :join, :index] do
    member do
      patch 'join'
    end
    # can you explain the line below? what is :member? and how does patch work?
    # kf: member routing requires an id to act on a specific resource item
    # unlike w/ collections which apply indiscriminately to the whole
    # we need this to call an update/patch for the join method
  end
  resources :pieces, only: :update
end
