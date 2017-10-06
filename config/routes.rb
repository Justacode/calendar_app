Rails.application.routes.draw do
  devise_for :users

  root 'users#show'

  resources :users, only:[:show] do
    member do
      resources :events
    end
  end
  
end
