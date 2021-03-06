Highr::Application.routes.draw do
  #set the root of the application to /pages/home
#  root :to => 'pages#home'

  resources :authentications
  match '/auth/:provider/callback' => 'authentications#create'

#  devise_for :pages, :controllers => {:home => 'home'}
#  devise_for :users, :controllers => {:registrations => 'registrations'}
  devise_for :users, :controllers => 
    {:registrations => 'registrations', :invitations => 'invitations'} do
    root :to => 'invitations#new'
  end
#  devise_for :users, :controllers => {:invitations => 'invitations'}

  #specify the routes for the static pages
  match '/contact', :to => 'pages#contact'
  match '/about', :to => 'pages#about'
  match '/help', :to => 'pages#help'

  #RESTful pages
  
  # enables GET request on /users to work 
  # (i.e. /users/1 will return the user record 
  # in the database with :id = 1)
  resources :users do
    member do
      get :team_mates
      get :teams
    end
  end

  # enable routs for teams
  resources :teams
  match '/teams/:id' => 'teams#add_team_mates'

  # resources for hartman value profile
  resources :hartman_value_profiles do
    member do
      get 'get_part1'
      put 'put_part1'
      get 'get_part2'
      put 'put_part2'
    end
  end

  # Microposts
  resources :microposts, :only => [:create, :destroy]

  #restrict sessions controler to only handle new, create and destroy
#  resources :user_sessions, :only => [:new, :create, :destroy] 


  #named routes
#  match '/signup', :to => 'users#new'
#  match '/signin', :to => 'devise/sessions#new'
#  match '/signout', :to => 'devise/sessions#destroy'

  
  # testing out routes for the HVP

#  match ({'users/:id' => 'users#edit'})
#  match ({'hartman_value_profiles/:id/part1' => 'hartman_value_profiles#part1'})

  # Authlogic routes
#  resources :user_sessions
#  match 'login' => 'user_sessions#new', :as => :login
#  match 'logout' => 'user_sessions#destroy', :as => :logout

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
