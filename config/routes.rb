Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show, :edit, :update]
  resources :tags, only: :index
  root 'books#index'
  resources :books do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: :create
    post :payment
    post :confirmation
  end
end
