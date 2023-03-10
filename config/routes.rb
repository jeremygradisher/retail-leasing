Rails.application.routes.draw do
  resources :contacts
  resources :primary_deals
  resources :leasing_managers
  resources :workletter_templates
  resources :workletters
  resources :schedules
  resources :dealimages
  resources :user_projects
  resources :areas_deals
  resources :deals
  resources :icons
  resources :projects
  resources :areas
  resources :images
  resources :maps
  resources :user_avatars
  resources :archived_projects
  
  devise_for :users, :controllers => { registrations: 'registrations', invitations: 'invitations' }

  
  get 'welcome/index'
  
  root 'welcome#index'
  
  resources :projects do
    member do
      get 'users'
      put 'add_user'
      # test reports
      get :testreport
      # reports
      get :leasestatusreport
      get :leasedealreport
      get :closeoutreport
      get :tenantstatusreport
      get :dealdirectoryreport
      #adding this for /tenants/1/projects/1/adhoc
      #get 'adhocreport'
      get 'spaces'
      get 'deals'
      get 'charts'
      get 'map'
      get 'retail'
      get 'merch'
    end
  end
  
  #resources :users, :only => [:index, :show, :destroy]
  resources :users
  
  #devise_for :users, :controllers => { registrations: 'my_devise/registrations' }
  
  resources :notifications do
    collection do
      post :mark_as_read
    end
  end
  
end