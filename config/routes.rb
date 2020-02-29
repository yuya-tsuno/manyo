Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  
  # get 'tasks#search', to: 'tasks/search'
end
