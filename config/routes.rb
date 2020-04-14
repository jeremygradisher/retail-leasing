Rails.application.routes.draw do
  resources :deals
  resources :icons
  resources :projects
  resources :areas
  resources :images
  resources :maps
  resources :user_avatars
  devise_for :users, :controllers => { registrations: 'registrations' }
  get 'welcome/index'
  
  root 'welcome#index'
  
  #resources :users, :only => [:index, :show, :destroy]
  resources :users
  
  #devise_for :users, :controllers => { registrations: 'my_devise/registrations' }
end
