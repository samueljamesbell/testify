ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.
	# a comment
  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

	map.resources :users, :member => { :choose_handle => [:get, :post], :company_profile => :get, :upload_logo => [:get, :post]} do |users|
		users.resources :reviews, :member => { :hide_name => [:get, :post], :unhide_name => [:get, :post] }
		users.resources :demands
	end
	
	map.resources :emails

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end
	
  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end
 
  map.connect '/go/:code', :controller => 'demands', :action => 'show'
	
	map.connect '/signup/:invite_code', :controller => 'users', :action => 'new'
	
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'  
  
  map.status_update '/twitter/status_update/:user_id/:review_id', :controller => 'twitter', :action => 'status_update'
  map.login '/login', :controller => 'sessions', :action => 'login'
  map.logout '/logout', :controller => 'sessions', :action => 'logout'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.welcome '/home', :controller => 'pages', :action => 'index'
  map.settings '/:id/settings', :controller => 'users', :action => 'edit'
  
  map.short_user '/:user_id', :controller => 'users', :action => 'show'
  map.formatted_short_user '/:user_id.:format', :controller => 'users', :action => 'show'
  map.short_new_user_review '/:user_id/reviews/new', :controller => 'reviews', :action => 'new'
  map.short_user_demands '/:user_id/demands', :controller => 'demands', :action => 'index'
  map.short_new_user_demand '/:user_id/demands/new', :controller => 'demands', :action => 'new'
  map.short_edit_user '/:id/edit', :controller => 'users', :action => 'edit'
  map.short_user_review '/:user_id/:id', :controller => 'reviews', :action => 'show'
  
  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"
  map.root :controller => 'pages', :action => 'index'

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  


  

end
