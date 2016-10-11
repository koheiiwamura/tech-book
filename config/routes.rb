Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :sessions => 'users/sessions' ,
    :registrations => 'users/registrations'
}
  namespace :users do
    resources :selled, only:[:index]
  end
  resources :users, only: [:show, :edit, :update]
  resources :addresses, only: :update
  resources :banks, only: [:create, :update]
  root 'books#index'
  get 'books/search' => 'books/search#index'
  resources :books do
    resources :orders, only: [:new, :create, :show]
    resources :likes, only: [:create, :destroy]
    resources :comments, only: :create
    post :payment
    post :confirmation
  end
end
