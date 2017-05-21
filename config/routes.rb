Rails.application.routes.draw do
  resources :glosarios

  resources :projects do
    resources :requirements do
      resources :comments
    end
  end

  devise_for :users

  root 'projects#index'
end
