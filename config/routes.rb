Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html4

  resources :learning_paths
  resources :courses
  resources :authors
  resources :talents

  post 'assign_talent_to_course', to: 'course_assignments#assign_talent_to_course'
  post 'assign_course_to_learning_path', to: 'course_assignments#assign_course_to_learning_path'

  resources :learning_path_attachments, only: [:create, :destroy]
end
