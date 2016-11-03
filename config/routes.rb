Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :sessions => 'users/sessions' ,
    :registrations => 'users/registrations',
    :omniauth_callbacks => "users/omniauth_callbacks"
}
  namespace :users do
    resources :selled, only:[:index]
  end
  resources :users, only: [:show, :edit, :update] do
    resources :orders, only: :index
  end
  resources :password_resets
  resources :addresses, only: [:create, :update]
  resources :banks, only: [:create, :update]
  root 'books#index'
  get 'books/search' => 'books/search#index'
  resources :books do
    resources :orders, only: [:new, :create, :index, :show]
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    post :payment
    post :confirmation
  end
end
