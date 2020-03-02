Rails.application.routes.draw do
  resources :users
  root 'tasks#index'
  resources :tasks
  
  # get 'tasks#search', to: 'tasks/search'
end
