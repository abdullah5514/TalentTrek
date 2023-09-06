Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html4
  resources :learning_paths
  resources :courses
  resources :authors
  resources :talents
end
