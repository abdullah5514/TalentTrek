Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html4

  resources :learning_paths do
    member do
      get :assign_courses_to_learning_path
      delete :remove_courses_from_learning_path
    end
  end
  resources :courses do
    member do
      put :complete_course
    end
  end
  resources :authors
  resources :talents do
    member do
      get :assign_courses_to_talent
      get :assign_learning_path_to_talent
      delete :remove_courses_from_talent
    end
  end
end
