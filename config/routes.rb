Rails.application.routes.draw do
  get 'home/index'
  get 'home/search'
  root to: 'home#index'

  resources :users, only: [:index, :show] do
    resources :articles, only: [:show], controller: 'users/articles'
  end

  resources :articles do
    resources :comments, only: [:create, :destroy]
  end

  resources :tags, only: [:index, :create, :destroy]

  devise_for :users, path: :devise, controllers: { registrations: 'registrations' }
end
