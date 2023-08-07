Rails.application.routes.draw do
  devise_for :admins, controllers:{
    sessions: 'admin/sessions',
    registrations: 'admin/registrations'
  }

  devise_for :users, controllers:{
    sessions: 'users/sessions' ,
    registrations: 'users/registrations'
  
  }
  resources :balance_transfers, only: [:new, :create]
 
  resources :plans, only: [:index,] do
    post 'upgrade', on: :member
  end
  
  resources :airtimes, only: [:index, :new, :create]
  
  get 'dashboard/user'
  get 'dashboard/admin'
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Defines the root path route ("/")
  # root "articles#index"
  
  
   
end
