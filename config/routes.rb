Rails.application.routes.draw do
  get 'friends/create'
  namespace :api do
    namespace :v1 do
      resources :tutorials, only:[:show, :index]
      resources :videos, only:[:show]
    end
  end

  root 'welcome#index'
  get 'tags/:tag', to: 'welcome#index', as: :tag
  get '/register', to: 'users#new'

  namespace :admin do
    get "/dashboard", to: "dashboard#show"
    resources :tutorials, only: [:create, :edit, :update, :destroy, :new] do
      resources :videos, only: [:create]
    end
    resources :videos, only: [:edit, :update, :destroy]

    namespace :api do
      namespace :v1 do
        put "tutorial_sequencer/:tutorial_id", to: "tutorial_sequencer#update"
      end
    end
  end

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

  get '/dashboard', to: 'users#show'
  get '/about', to: 'about#show'
  get '/get_started', to: 'get_started#show'

  # Is this being used?
  get '/video', to: 'video#show'

  resources :users, only: [:new, :create, :update, :edit]

  resources :tutorials, only: [:show, :index] do
    resources :videos, only: [:show, :index]
  end

  resources :user_videos, only:[:create, :destroy]

  get '/auth/github', as: :github_oauth
  get '/auth/github/callback', to: 'github/sessions#create', as: :github_callback
  get '/login/verify', to: 'sessions/validation#index', as: :validation_landing
  get '/login/verify/:id', to: 'sessions/validation#show', as: :validate_user
  get '/invite', to: 'invites#new'
  post '/invite', to: 'invites#create'
  post '/friends/:friend_uid', to: 'friends#create', as: :friends
  put '/friends/:friend_id', to: 'friends#update', as: :accept_friends
  delete '/friends/:friend_id', to: 'friends#destroy', as: :decline_friends
end
