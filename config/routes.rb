Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'static_pages#index'
  resources :games, only: [:index, :new, :create, :show, :edit, :update] do
    put 'forfeit', on: :member
    resources :pieces, only: [:index, :create, :show, :update] do
      get 'permitted', on: :member
    end
  end
end
