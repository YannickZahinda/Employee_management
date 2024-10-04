Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
  resources :reports, only: [:index, :new, :create]
  resources :sick_leaves, only: [:index, :new, :create]
  resources :meetings, only: [:index]
  resources :attendances, only: [:index]

  namespace :admin do 
    resources :users, only: [:index, :new, :create]
    resources :sick_leaves, only: [:index] do
      member do
        patch :approve
        patch :reject
      end
    end
    resources :meetings, only: [:new, :create]
    resources :attendances, only: [:new, :create]
  end
end
