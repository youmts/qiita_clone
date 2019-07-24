Rails.application.routes.draw do
  get 'home/index'
  get 'home/search'
  root to: 'home#index'

  resources :users, only: [:index, :show]

  resources :articles do
    resources :comments, only: [:create, :destroy]

    collection do
      get :drafts
    end

    member do
      post :like, controller: :likes
      delete :unlike, controller: :likes
    end
  end

  resources :tags, only: [:index, :show, :create, :destroy]

  devise_for :users, path: :devise, controllers: { registrations: 'registrations' }
end
