Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'static_pages#index'
  resources :games, only: [:index, :new, :create, :show, :edit, :update] do
    resources :pieces, only: [:create, :show, :update]
  end
end
