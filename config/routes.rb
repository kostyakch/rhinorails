RhinoCMS::Application.routes.draw do
  # Admin URLs

  mount Rhinoart::Engine, at: "/admin"


  # Site URLs
  # resources :sessions, only: [:new, :create, :destroy]

  # match '/signup',  to: 'users#new', via: [:get]
  # match '/users',  to: 'users#create', :as => :users, via: [:get, :post]
  # match '/login',  to: 'sessions#new', via: [:get]
  # match '/logout', to: 'sessions#destroy', via: [:delete, :get]

  match '/messages', to: 'messages#create', via: :post
  match '/messages/new', to: 'messages#new', via: [:get]

  resources :page_comments, only: [:new, :create]

  root :to => 'pages#index'
  match '*url' => 'pages#internal', :as => :page, via: [:get]
end

