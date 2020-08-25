Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/dashboard', to: 'users#dashboard', as: 'dashboard'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :projects, only: [:new, :create, :update, :index, :show] do
    resources :project_steps, only: [:create, :index]
    resources :user_projects, only: [:create, :show]
  end
  resources :user_projects, only: [:show, :update]
  resources :chatrooms, only: :show do
    resources :messages, only: :create
  end
end
