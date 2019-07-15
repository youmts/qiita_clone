Rails.application.routes.draw do
  get 'home/index'
  get 'home/search'
  root to: 'home#index'

  resources :users, only: [:index, :show] do
    resources :articles, only: [:show], controller: 'users/articles'
  end

  resources :articles
  resources :tags, only: [:index] do
    member do
      post :add
      delete :remove
    end
  end

  devise_for :users, path: :devise, controllers: { registrations: 'registrations' }
end
