Rails.application.routes.draw do
  resources :comments
  resources :requirements
  resources :projects
  devise_for :users
  resources :glosarios


  root 'glosarios#index'
end
