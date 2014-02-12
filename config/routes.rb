ScisciNotes::Application.routes.draw do


  devise_for :users, :controllers => { :registrations => "registrations" }
# need to add in custom redirects on login controller

  get 'projects/new', to: 'projects#new'
  get 'sources/new', to: 'sources#new'
  post 'collaborator', to: 'projects#add_collaborator'
  get 'project/:project_id/search_users', to: 'search#users'

  get 'section/:id/projects', to: 'sections#index'

  resources :sections

#  scope 'teachers/:id' do
#    resources :projects, shallow: true
#  end

  resources :users do
    resources :projects, shallow: true
  end

  resources :projects do
    resources :sources, shallow: true
  end

  resources :sources do
    resources :notes, shallow: true
  end


  get 'projects/:project_id/tags/:name', to: 'tags#show', :as => :project_tags
      
  
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
