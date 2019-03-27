Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tutorials, only:[:show, :index]
      resources :videos, only:[:show]
      post '/bookmarks/:id', to: "bookmarks#create"
    end
  end

  root 'welcome#index'
  get 'tags/:tag', to: 'welcome#index', as: :tag
  get '/about', to: 'about#show'
  get '/get_started', to: 'get_started#show'

  get '/register', to: 'users#new'
  get '/activate/:id', to: 'activation#activate', as: :activate
  get '/dashboard', to: 'users#show'
  resources :users, only: [:create, :update, :edit]

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

  post '/connect', to: redirect('/auth/github')
  get 'auth/:provider/callback', to: 'github_connection#create'
  get '/auth/failure', to: redirect('/dashboard')
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

  # Is this being used?
  get '/video', to: 'video#show'

  resources :tutorials, only: [:show, :index] do
    resources :videos, only: [:show, :index]
  end

  resources :user_videos, only:[:create, :destroy]

  post '/friendships', to: "friendships#create", as: "new_friendship"
end
