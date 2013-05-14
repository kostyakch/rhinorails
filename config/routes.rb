RhinoCMS::Application.routes.draw do

  # Admin URLs
  namespace :admin do
    root :to => 'dashboard#index'

    match '/page/:id/show_hide' => 'pages#showhide', :as => :page_showhide
    match '/page/:parent_id/list' => 'pages#children', :as => :page_children
    match '/page/:parent_id/new' => 'pages#new', :as => :new_children_page
    match '/page/tree' => 'pages#tree', :as => :pages_tree
    resources :pages

    match '/structures/:parent_id/new' => 'structures#new', :as => :new_children_structures
    resources :structures

    resources :users
    resources :settings
    resources :dashboard
    resources :gallery
  end


  # Site URLs
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  match '/signup',  to: 'users#new'
  match '/login',  to: 'sessions#new'
  match '/logout', to: 'sessions#destroy', via: :delete

  root :to => 'pages#index'
  match '*url' => 'pages#internal', :as => :page


   #     admin_settings GET    /admin/settings(.:format)                  admin/settings#index
   #                    POST   /admin/settings(.:format)                  admin/settings#create
   #  new_admin_setting GET    /admin/settings/new(.:format)              admin/settings#new
   # edit_admin_setting GET    /admin/settings/:id/edit(.:format)         admin/settings#edit
   #      admin_setting GET    /admin/settings/:id(.:format)              admin/settings#show
   #                    PUT    /admin/settings/:id(.:format)              admin/settings#update
   #                    DELETE /admin/settings/:id(.:format)              admin/settings#destroy

  # resources :pages do
  #   collection do
  #     #site.root                                                    :action => 'show_page', :url => '/'
  #     #site.not_found         'error/404',                          :action => 'not_found'
  #     #site.error             'error/500',                          :action => 'error'

  #     # Everything else
  #     get '*url', :action => 'index'
  #   end
  # end
  # resources :page_contents
  # resources :pages
  # resources :users

  #match '/' => 'users#index' 
  #match '/' => 'pages#index' 
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
