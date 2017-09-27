Rails.application.routes.draw do
  devise_for :users

  root 'users#show'

  resources :events
  resources :users, path: 'users', only: [:show]
  
  get 'users/:id' => 'users#show'



end
