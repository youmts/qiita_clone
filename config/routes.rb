Rails.application.routes.draw do
  get 'home/index'
  root to: 'home#index'

  resources :users, only: [:index, :show] do
    resources :articles
  end

  devise_for :users, path: :devise, controllers: { registrations: 'registrations' }
end
