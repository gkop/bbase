Bbase::Application.routes.draw do

 
  root :to => "home#dashboard"
  
  get '/cities/created' => 'cities#created'
  get '/sites/created' => 'sites#created'
  
  resources :sites

  resources :cities

  resources :artworks
  
  devise_for :users do
    # block new user registration
    get "/users/sign_up(.:format)" => "invites#new"
    post "/users(.:format)" => "invites#new"
  end

  resources :users, :only => [ :index, :show ]

  get '/homepage' => "home#homepage", :as => "homepage"
  get '/dashboard' => "home#dashboard", :as => "dashboard"
  get '/about' => "home#about", :as => "about"
  get '/contact' => "home#contact", :as => "contact"

  get "/images/uploads/*path" => "gridfs#serve"

  put "/exhibitions/:id/add/:artwork_id" => "exhibitions#add", :as => :add_artwork_to_exhibition
  put "/exhibitions/:id/remove/:artwork_id" => "exhibitions#remove", :as => :remove_artwork_from_exhibition

  resources :exhibitions

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
  #root :to => "home#homepage"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
