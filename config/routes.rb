Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "pages#home"
  get "about", to: "pages#about"
  get "signup", to: "users#new"
  #post "users", to: "users#create"
  resources :users, except: [:new]
  resources :articles#, only: [:show, :index, :create, :new, :edit, :update, :destroy]
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  resources :categories, except: [:destroy]
end