Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
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
    resources :requirements do
      collection do
        get ':id/select', to: 'requirements#select', as: 'select'
        get 'new_modal', to: 'requirements#new_modal', as: 'new_modal'
      end
    end
  end

  root 'projects#index'
end
