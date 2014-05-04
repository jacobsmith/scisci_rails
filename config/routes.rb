ScisciNotes::Application.routes.draw do


  devise_for :users, :controllers => { :registrations => "registrations" }
# need to add in custom redirects on login controller

  resources :charges

  get 'projects/new', to: 'projects#new'
  get 'sources/new', to: 'sources#new'
  post 'collaborator', to: 'projects#add_collaborator'
  get 'project/:project_id/search_users', to: 'search#users'

  get 'section/:section_id/project/:section_project_id', to: 'sections#section_project', as: 'section_project'
#  get 'section/:id/new_project', to: 'sections#new_section_project'
  patch 'section/:id/new_project', to: 'sections#create_section_project', as: 'create_section_project'

  resources :teachers do
    resources :sections, shallow: true
  end

  resources :sections do
    resources :projects, shallow: true
  end

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
  get 'projects/:project_id/tags', to: 'tags#index', :as => :project_tags_index
  get 'projects/:project_id/notes', to: 'notes#project_index', :as => :project_notes
  delete 'projects/:project_id/tags/:name', to: 'tags#destroy_all', :as => :tags_destroy
  match 'projects/:project_id/tags/:name', to: 'tags#rename_all', :as => :tags_rename, via: [:post, :patch] 
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
