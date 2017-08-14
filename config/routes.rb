Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users

  resources :projects do
    collection do
      get ':id/show_modal', to: 'projects#show_modal', as: 'show_modal'
      get ':id/export_csv', to: 'projects#export_csv', as: 'export_csv'
      get 'archived', to: 'projects#index_archived', as: 'archived'
      post ':id/archive', to: 'projects#archive', as: 'archive'
    end
    resources :requirements do
      collection do
        get ':id/select', to: 'requirements#select', as: 'select'
        get 'new_modal', to: 'requirements#new_modal', as: 'new_modal'
      end
      resources :comments
    end
    resources :keywords
  end

  resources :logs

  root 'projects#index'
end
