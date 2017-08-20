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

#                 new_user_session GET    /users/sign_in(.:format)                                                       devise/sessions#new
#                     user_session POST   /users/sign_in(.:format)                                                       devise/sessions#create
#             destroy_user_session DELETE /users/sign_out(.:format)                                                      devise/sessions#destroy
#                new_user_password GET    /users/password/new(.:format)                                                  devise/passwords#new
#               edit_user_password GET    /users/password/edit(.:format)                                                 devise/passwords#edit
#                    user_password PATCH  /users/password(.:format)                                                      devise/passwords#update
#                                  PUT    /users/password(.:format)                                                      devise/passwords#update
#                                  POST   /users/password(.:format)                                                      devise/passwords#create
#         cancel_user_registration GET    /users/cancel(.:format)                                                        devise/registrations#cancel
#            new_user_registration GET    /users/sign_up(.:format)                                                       devise/registrations#new
#           edit_user_registration GET    /users/edit(.:format)                                                          devise/registrations#edit
#                user_registration PATCH  /users(.:format)                                                               devise/registrations#update
#                                  PUT    /users(.:format)                                                               devise/registrations#update
#                                  DELETE /users(.:format)                                                               devise/registrations#destroy
#                                  POST   /users(.:format)                                                               devise/registrations#create
#              show_modal_projects GET    /projects/:id/show_modal(.:format)                                             projects#show_modal
#              export_csv_projects GET    /projects/:id/export_csv(.:format)                                             projects#export_csv
#                archived_projects GET    /projects/archived(.:format)                                                   projects#index_archived
#                 archive_projects POST   /projects/:id/archive(.:format)                                                projects#archive
#      select_project_requirements GET    /projects/:project_id/requirements/:id/select(.:format)                        requirements#select
#   new_modal_project_requirements GET    /projects/:project_id/requirements/new_modal(.:format)                         requirements#new_modal
#     project_requirement_comments GET    /projects/:project_id/requirements/:requirement_id/comments(.:format)          comments#index
#                                  POST   /projects/:project_id/requirements/:requirement_id/comments(.:format)          comments#create
#  new_project_requirement_comment GET    /projects/:project_id/requirements/:requirement_id/comments/new(.:format)      comments#new
# edit_project_requirement_comment GET    /projects/:project_id/requirements/:requirement_id/comments/:id/edit(.:format) comments#edit
#      project_requirement_comment GET    /projects/:project_id/requirements/:requirement_id/comments/:id(.:format)      comments#show
#                                  PATCH  /projects/:project_id/requirements/:requirement_id/comments/:id(.:format)      comments#update
#                                  PUT    /projects/:project_id/requirements/:requirement_id/comments/:id(.:format)      comments#update
#                                  DELETE /projects/:project_id/requirements/:requirement_id/comments/:id(.:format)      comments#destroy
#             project_requirements GET    /projects/:project_id/requirements(.:format)                                   requirements#index
#                                  POST   /projects/:project_id/requirements(.:format)                                   requirements#create
#          new_project_requirement GET    /projects/:project_id/requirements/new(.:format)                               requirements#new
#         edit_project_requirement GET    /projects/:project_id/requirements/:id/edit(.:format)                          requirements#edit
#              project_requirement GET    /projects/:project_id/requirements/:id(.:format)                               requirements#show
#                                  PATCH  /projects/:project_id/requirements/:id(.:format)                               requirements#update
#                                  PUT    /projects/:project_id/requirements/:id(.:format)                               requirements#update
#                                  DELETE /projects/:project_id/requirements/:id(.:format)                               requirements#destroy
#                 project_keywords GET    /projects/:project_id/keywords(.:format)                                       keywords#index
#                                  POST   /projects/:project_id/keywords(.:format)                                       keywords#create
#              new_project_keyword GET    /projects/:project_id/keywords/new(.:format)                                   keywords#new
#             edit_project_keyword GET    /projects/:project_id/keywords/:id/edit(.:format)                              keywords#edit
#                  project_keyword GET    /projects/:project_id/keywords/:id(.:format)                                   keywords#show
#                                  PATCH  /projects/:project_id/keywords/:id(.:format)                                   keywords#update
#                                  PUT    /projects/:project_id/keywords/:id(.:format)                                   keywords#update
#                                  DELETE /projects/:project_id/keywords/:id(.:format)                                   keywords#destroy
#                         projects GET    /projects(.:format)                                                            projects#index
#                                  POST   /projects(.:format)                                                            projects#create
#                      new_project GET    /projects/new(.:format)                                                        projects#new
#                     edit_project GET    /projects/:id/edit(.:format)                                                   projects#edit
#                          project GET    /projects/:id(.:format)                                                        projects#show
#                                  PATCH  /projects/:id(.:format)                                                        projects#update
#                                  PUT    /projects/:id(.:format)                                                        projects#update
#                                  DELETE /projects/:id(.:format)                                                        projects#destroy
#                             logs GET    /logs(.:format)                                                                logs#index
#                                  POST   /logs(.:format)                                                                logs#create
#                          new_log GET    /logs/new(.:format)                                                            logs#new
#                         edit_log GET    /logs/:id/edit(.:format)                                                       logs#edit
#                              log GET    /logs/:id(.:format)                                                            logs#show
#                                  PATCH  /logs/:id(.:format)                                                            logs#update
#                                  PUT    /logs/:id(.:format)                                                            logs#update
#                                  DELETE /logs/:id(.:format)                                                            logs#destroy
#                             root GET    /                                                                              projects#index
