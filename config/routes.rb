Rails.application.routes.draw do
  get 'home/index'
  root to: 'home#index'

  resources :users, only: [:index, :show]
  resources :articles

  devise_for :users, path: :devise, controllers: { registrations: 'registrations' }
end
