EventCAlendar::Application.routes.draw do

  get "static_pages/home"
  get "static_pages/about"
  get "static_pages/contact"
  #get "omniauth_callbacks/facebook"
  #get "omniauth_callbacks/vkontakte"
  
  # Omniauth
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks" }
  
  resources :users, only: [:update, :destroy]
  
  root :to => 'static_pages#home'
  get 'profile' => 'users#show', as: 'profile'
  
  resources :events
  get '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}
  get "/calendar/:year/:month/:day", :controller => "calendar", :action => "day"
  get "calendar/day", :controller => "calendar", :action => "day"
  
  resources :notes
  resources :invitations, only: [:destroy]
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

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
