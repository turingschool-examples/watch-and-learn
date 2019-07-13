# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tutorials, only: %i[show index]
      resources :videos, only: [:show]
    end
  end

  root 'welcome#index'
  get 'tags/:tag', to: 'welcome#index', as: :tag
  get '/register', to: 'users#new'

  namespace :admin do
    get '/dashboard', to: 'dashboard#show'
    resources :tutorials, only: %i[create new update edit destroy] do
      resources :videos, only: [:create]
    end
    resources :videos, only: %i[edit update]

    namespace :api do
      namespace :v1 do
        put 'tutorial_sequencer/:tutorial_id', to: 'tutorial_sequencer#update'
      end
    end
  end

  get '/activation', to: 'activation#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get 'auth/github/callback', to: 'users#update'

  get '/dashboard', to: 'users#show'
  get '/about', to: 'about#show'
  get '/get_started', to: 'get_started#show'

  resources :users, only: %i[new create update]

  resources :tutorials, only: %i[show]

  resources :user_videos, only: %i[create]

  post '/friendship', to: 'friendships#create'

  get '/invite', to: 'invites#new'
  post '/invite', to: 'invites#create'


  # Is this being used?

  # get '/video', to: 'video#show'
  # admin/tutorial#destroy
  # admin/videos#destroy
  # users#edit
  # videos#index (nested under resources: tutorials
  # videos#show (nested under resources: tutorials
  # tutorials#index
  # user_videos#destroy
end
