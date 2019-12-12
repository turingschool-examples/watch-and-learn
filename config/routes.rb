Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tutorials, only: [:show, :index]
      resources :videos, only: [:show]
    end
  end

  namespace :admin do
    get '/dashboard', to: 'dashboard#show'
    resources :videos, only: [:edit, :update, :destroy]
    resources :tutorials, except: [:index, :show] do
      resources :videos, only: [:create]
    end
  end

  resources :tutorials, only: [:show, :index]
  resources :users, only: [:new, :create, :update, :edit]
  resources :user_videos, only: [:create, :destroy]
  resources :friendships, only: [:create]

  root 'welcome#index'
  get 'tags/:tag', to: 'welcome#index', as: :tag
  get '/about', to: 'about#show'
  get '/get_started', to: 'get_started#show'

  get '/register', to: 'users#new'
  get '/users/activation', to: 'activation#update'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/dashboard', to: 'users#show'
  get '/invite', to: 'invite#new'
  post '/invite', to: 'invite#create'
  get '/auth/github', as: 'github_login'
  get '/auth/:provider/callback', to: 'sessions#update'
end
