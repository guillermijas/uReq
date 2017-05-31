Rails.application.routes.draw do
  resources :glossaries
  resources :logs
  devise_for :users
  resources :comments

  resources :projects do
    collection do
      get ':id/show_modal', to: 'projects#show_modal', as: 'show_modal'
      get 'archived', to: 'projects#index_archived', as: 'archived'
      post ':id/archive', to: 'projects#archive', as: 'archive'
    end
    resources :requirements
  end

  root 'projects#index'
end
