ScisciNotes::Application.routes.draw do


  resources :blog_posts, path: '/blog'

  devise_for :users, :controllers => { :registrations => "registrations" }
# need to add in custom redirects on login controller

  get 'projects/new', to: 'projects#new'
  get 'projects/:project_id/thesis/new', to: 'projects#new_thesis', as: 'new_thesis'
  post 'projects/:project_id/thesis/create', to: 'projects#create_thesis', as: 'create_thesis'
  post 'projects/:project_id/edit', to: 'projects#update'
  post 'projects/:project_id', to: 'projects#change_active_state'

  get 'sources/new', to: 'sources#new'
  post 'collaborator', to: 'projects#add_collaborator'
  get 'project/:project_id/search_users', to: 'search#users'

  get '.well-known/acme-challenge/:challenge', to: 'lets_encrypt#challenge'

  get 'section/:section_id/project/:section_project_id', to: 'sections#section_project', as: 'section_project'
  patch 'section/:id/new_project', to: 'sections#create_section_project', as: 'create_section_project'

  get 'view-plans', to: 'plans#view_plans', as: 'view_plans'
  post 'change-plan', to: 'plans#change_plan'
  get 'pricing', to: 'static_pages#pricing', as: 'pricing'
  get 'about', to: 'static_pages#about', as: 'about'
  get 'for_schools', to: 'static_pages#for_schools', as: 'for_schools'
  post 'for_schools_form', to: 'static_pages#for_schools_form', as: 'for_schools_form'
  post 'feedback_form', to: 'static_pages#feedback_form', as: 'feedback_form'
  get 'upcoming_features', to: 'static_pages#upcoming_features', as: 'upcoming_features'


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
  get 'examples/theses', to: 'static_pages#example_theses', as: :example_theses
  root :to => 'static_pages#home'
end
