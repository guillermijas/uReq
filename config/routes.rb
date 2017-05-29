Rails.application.routes.draw do
  resources :glossaries
  resources :logs
  devise_for :users
  resources :comments
  resources :requirements

  resources :projects do
    collection do
      get ':id/show_modal', to: 'projects#show_modal', as: 'show_modal'
      get ':id/delete_picture', to: 'projects#delete_picture', as: 'delete_picture'
    end
  end

  root 'projects#index'
end
