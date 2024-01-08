Rails.application.routes.draw do
  resources :photos, only: [:index]
  resources :submissions, only: [:new, :create]
  #get 'submissions/new'
  #get 'submissions/create'
  get 'riders/index'
  #get 'photos/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
