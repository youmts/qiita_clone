Rails.application.routes.draw do
  get 'home/index'

  devise_for :users, path: :devise, controllers: { registrations: 'registrations' }

  root to: 'home#index'
end
