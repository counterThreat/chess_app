Rails.application.routes.draw do
  # devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :users, only: [:index]

  root 'static_pages#index'
  resources :pieces, only: [:update]

  resources :games, only: [:index, :new, :create, :show, :edit, :update] do
    get 'data_view', on: :member
    post 'forfeit', on: :member
    resources :pieces, only: [:index, :create, :show, :update]
  end
end
