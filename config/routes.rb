Rails.application.routes.draw do



  #get "/", :controller => "index", :action => "show"


  root to: 'index#show'

  devise_for :users

  # Routes for the Users_input resource:
  # CREATE
  get "/users_inputs/new", :controller => "users_inputs", :action => "new"
  post "/create_users_input", :controller => "users_inputs", :action => "create"

  # READ
  get "/users_inputs", :controller => "users_inputs", :action => "index"
  get "/users_inputs/:id", :controller => "users_inputs", :action => "show"

  # UPDATE
  get "/users_inputs/:id/edit", :controller => "users_inputs", :action => "edit"
  post "/update_users_input/:id", :controller => "users_inputs", :action => "update"

  # DELETE
  get "/delete_users_input/:id", :controller => "users_inputs", :action => "destroy"
  #------------------------------

  # Routes for the Recommendation resource:
  # CREATE
  get "/recommendations/new", :controller => "recommendations", :action => "new"
  post "/create_recommendation", :controller => "recommendations", :action => "create"

  # READ
  get "/recommendations", :controller => "recommendations", :action => "index"
  get "/recommendations/:id", :controller => "recommendations", :action => "show"

  # UPDATE
  get "/recommendations/:id/edit", :controller => "recommendations", :action => "edit"
  post "/update_recommendation/:id", :controller => "recommendations", :action => "update"

  # DELETE
  get "/delete_recommendation/:id", :controller => "recommendations", :action => "destroy"
  #------------------------------

  # Routes for the Exercise resource:
  # CREATE
  get "/exercises/new", :controller => "exercises", :action => "new"
  post "/create_exercise", :controller => "exercises", :action => "create"

  # READ
  get "/exercises", :controller => "exercises", :action => "index"
  get "/exercises/:id", :controller => "exercises", :action => "show"

  # UPDATE
  get "/exercises/:id/edit", :controller => "exercises", :action => "edit"
  post "/update_exercise/:id", :controller => "exercises", :action => "update"

  # DELETE
  get "/delete_exercise/:id", :controller => "exercises", :action => "destroy"
  #------------------------------

  # Routes for the Meal resource:
  # CREATE
  get "/meals/new", :controller => "meals", :action => "new"
  post "/create_meal", :controller => "meals", :action => "create"

  # READ
  get "/meals", :controller => "meals", :action => "index"
  get "/meals/:id", :controller => "meals", :action => "show"

  # UPDATE
  get "/meals/:id/edit", :controller => "meals", :action => "edit"
  post "/update_meal/:id", :controller => "meals", :action => "update"

  # DELETE
  get "/delete_meal/:id", :controller => "meals", :action => "destroy"
  #------------------------------

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
