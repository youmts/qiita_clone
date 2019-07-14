Rails.application.routes.draw do
  get 'home/index'
  root to: 'home#index'

  resources :users, only: [:index, :show] do
    resources :articles, only: [:show], controller: 'users/articles'
  end

  resources :articles

  devise_for :users, path: :devise, controllers: { registrations: 'registrations' }
end
