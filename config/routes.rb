Rails.application.routes.draw do
  root 'sessions#new'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  resources :tasks do
    get :search, on: :collection
  end
  get "/admin" => "admin/users#index"
  namespace :admin do
    resources :users
  end
end