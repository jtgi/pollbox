Roomfeed::Application.routes.draw do

  get "sessions/new"

  get "backbone/app"

	scope 'api', defaults: {format: 'json'} do
		scope 'v1' do
      devise_for :users

			get "/user" => "users#user"

			resources :registrations, :only => [:create, :destroy]

			resources :poll_option, :only=>[:create, :destroy]

      match "poll_option/:id/vote", to: "poll_options#vote", via:[:post]

			resources :polls, :except=>[:index]

      match "polls/:id/open", to: "polls#open", via:[:put]
      match "polls/:id/close", to: "polls#close", via:[:put]

      resources :rooms

  		resources :rooms, :shallow=>true do
    		resources :questions, :only=>[:index, :create]
				resources :polls, :only=>[:index, :create]
				resources :subscriptions, :only => [:create]
  		end

			resources :subscriptions, :only=>[:destroy, :update]

  		resources :questions, :except=>[:index], :shallow=>true do
  		  resources :answers, :only=>[:index, :create]
  		end

		end
	end

  #devise_for :users, :controllers=>{:sessions=>'sessions'}

  root :to => "backbone#app"

 # resources :users, :shallow=>true do
 #   resources :rooms, :only=>[:index]
 #   resources :answers, :only=>[:index]
 #   resources :questions, :only=>[:index]
 # 	resources :polls, :only=>[:index]
 # end
	#resources :registrations, :only => [:create, :destroy]
	
	resources :poll_option, :only=>[:create, :destroy]

	resources :polls, :except=>[:index]


  resources :rooms, :shallow=>true do
    resources :questions, :only=>[:index, :create]
		resources :polls, :only=>[:index, :create]
  end
  resources :questions, :except=>[:index], :shallow=>true do
    resources :answers, :only=>[:index, :create]
  end

  resources :answers, :except=>[:index]

  #match '/dashboard', to: 'dashboard#index'

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
