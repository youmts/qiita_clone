Rails.application.routes.draw do
  get 'home/index'

  devise_for :users, path: :devise

  root to: 'home#index'
end
