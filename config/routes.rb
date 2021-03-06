Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  resources :users, only:[:show, :new, :edit, :create, :update]
  resources :sessions, only: [:new, :create, :destroy]

  namespace :admin do
    root 'tasks#index'
    resources :tasks
    resources :users
  end
end
