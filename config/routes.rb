ScisciNotes::Application.routes.draw do

  match "users/:user_id", to: "projects#index", via: [:get]

  match "users/:user_id/projects", to: "projects#index", via: :get
  match "users/:user_id/projects", to: "projects#create", via: [ :post ]
  match "users/:user_id/projects/new", to: "projects#new", via: [ :get ]
  match "users/:user_id/projects/:project_id", to: "projects#show", via: :get
  match "users/:user_id/projects/:project_id", to: "projects#update", via: [ :patch, :put ]
  match "users/:user_id/projects/:project_id", to: "projects#destroy", via: [ :delete ]

  match "users/:user_id/projects/:project_id/sources", to: "sources#index", via: :get  
  match "users/:user_id/projects/:project_id/sources", to: "sources#create", via: :post 
  match "users/:user_id/projects/:project_id/sources/new", to: "sources#new", via: :get 
  match "users/:user_id/projects/:project_id/sources/:source_id", to: "sources#show", via: :get 
  match "users/:user_id/projects/:project_id/sources/:source_id", to: "sources#update", via: [ :patch, :put ] 
  match "users/:user_id/projects/:project_id/sources/:source_id", to: "sources#destroy", via: :delete 

  match "users/:user_id/projects/:project_id/sources/:source_id/notes", to: "notes#index", via: :get 
  match "users/:user_id/projects/:project_id/sources/:source_id/notes", to: "notes#create", via: :post
  match "users/:user_id/projects/:project_id/sources/:source_id/notes/new", to: "notes#new", via: :get
  match "users/:user_id/projects/:project_id/sources/:source_id/notes/:note_id", to: "notes#show", via: :get
  match "users/:user_id/projects/:project_id/sources/:source_id/notes/:note_id", to: "notes#update", via: [ :patch, :put ] 
  match "users/:user_id/projects/:project_id/sources/:source_id/notes/:note_id", to: "notes#destroy", via: :delete
  
  get 'projects/:project_id/tags/:name', to: 'tags#show', :as => :project_tags
      
  devise_for :users
  
  root :to => 'static_pages#home'
  
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
