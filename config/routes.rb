Rails.application.routes.draw do

  # Defines the root path route ("/")
  root "pages#home"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Auth routes
   devise_for :users, path: '', path_names: {sign_up: 'register', sign_in: 'login', edit: 'profile', sign_out: 'logout'}
   get '/dashboard',  to: 'users#dashboard'
   get '/users/:id', to: 'users#show', as: 'users'

   
   post '/users/edit', to: 'users#update'
end
