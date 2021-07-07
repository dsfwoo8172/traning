Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  
  get '/user/sign_up', to: 'registrations#new'
  post '/user/sign_up', to: 'registrations#create'

  get '/user/edit_password', to: 'passwords#edit'
  patch '/user/edit_password', to: 'passwords#update'

  get '/user/sign_in', to: 'sessions#new'
  post '/user/sign_in', to: 'sessions#create'
  
  delete '/user/logout', to: 'sessions#destroy'

  namespace :admin do
    resources :users
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
