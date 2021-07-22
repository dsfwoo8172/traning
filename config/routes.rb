Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  # 註冊
  get '/user/sign_up', to: 'registrations#new'
  post '/user/sign_up', to: 'registrations#create'
  # 編輯使用者
  get '/user/edit_user', to: 'users#edit'
  patch '/user/edit_user', to: 'users#update'
  # 登入
  get '/user/sign_in', to: 'sessions#new'
  post '/user/sign_in', to: 'sessions#create'

  delete '/user/logout', to: 'sessions#destroy' # 登出

  namespace :admin do
    resources :users
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
