Rails.application.routes.draw do
  resources :glossaries
  resources :logs
  devise_for :users
  resources :comments
  resources :requirements
  resources :projects

  root 'projects#index'
end
