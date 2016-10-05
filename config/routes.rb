Rails.application.routes.draw do
  # root 'devise/sessions#create', as: 'user_session_path'
  # get "/users/sign_in" => redirect(""), :defaults  => { :alert => 'aaaaa'  }
  post "/users"         => redirect(""), flash: {success: 'ERROR!!'}
  devise_for :users
  namespace :users do
    resources :selled, only:[:index]
  end
  resources :users, only: [:show, :edit, :update]
  resources :addresses, only: :update
  resources :banks, only: :update
  resources :tags, only: :index
  root 'books#index'
  get 'books/search' => 'books/search#index'
  resources :books do
    resources :orders, only: [:new, :create]
    resources :likes, only: [:create, :destroy]
    post :payment
    post :confirmation
  end
end
