Rails.application.routes.draw do
  get 'home/index'
  root to: 'home#index'

  resource :users, only: [:index, :show]

  devise_for :users, path: :devise, controllers: { registrations: 'registrations' }
end
