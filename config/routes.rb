Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/dashboard', to: 'users#dashboard', as: 'dashboard'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :projects, only: [:index, :show] do
    resources :project_steps, only: [:index]
    resources :user_projects, only: [:create]
  end
  resources :user_projects, only: [:show]
end
