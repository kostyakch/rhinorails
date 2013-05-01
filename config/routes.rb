RhinoCMS::Application.routes.draw do


  # Admin URLs
  namespace :admin do        
    match '/' => "pages#index"

    resources :pages
  end


#     admin_pages GET    /admin/pages(.:format)            admin/pages#index
#                 POST   /admin/pages(.:format)            admin/pages#create
#  new_admin_page GET    /admin/pages/new(.:format)        admin/pages#new
# edit_admin_page GET    /admin/pages/:id/edit(.:format)   admin/pages#edit
#      admin_page GET    /admin/pages/:id(.:format)        admin/pages#show
#                 PUT    /admin/pages/:id(.:format)        admin/pages#update
#                 DELETE /admin/pages/:id(.:format)        admin/pages#destroy


  # Site URLs
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

  root :to => 'pages#index'
  match '*url' => 'pages#index', :as => :page

  

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
