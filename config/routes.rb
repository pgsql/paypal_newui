Calculator::Application.routes.draw do

  #get "general/contact"
  put "general/save_contact"

  get "about" => "general#about"
  get "tour" => "general#tour"
  get "pricing" => "general#pricing"
  get "contact" => "general#contact"

  root :to => "general#index"
  
  resources :orders do
    collection do
      get 'success'
      get 'failure'
      get 'coupons_form'
      put 'calculate_amount'
    end
  end

  namespace :admin do 
    resources :categories
    resources :payment_options
    resources :coupons
    resources :states
    resources :colleges do
      get 'import', :on => :collection
      post 'import', :on => :collection
    end
    resources :users
  end

  devise_for :users
  resource :college_choices 
  resource :welcome

  resources :surveys do
    collection do
      get 'result'
    end
  end



  get "expired" => "expired#index"
  
  get "admin/dashboard" => "admin/dashboard#index"
  get "college" => "college#index"
  post "college" => "college#state_selected"

  root :to => "general#index"
 # root :to => 'sessions#new', :via => :get

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
