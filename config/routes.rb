Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html4
  resources :learning_paths do
    post :assign_talent
  end
  # config/routes.rb
# config/routes.rb
 post 'assign_talent_to_course', to: 'course_assignments#assign_talent_to_course'

 post 'assign_course_to_learning_path', to: 'course_assignments#assign_course_to_learning_path'
 resources :learning_path_assignments, only: [:create, :destroy]



  resources :courses
  resources :authors
  resources :talents
end
