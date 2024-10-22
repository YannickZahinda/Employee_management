Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
  resources :reports, only: [:index, :new, :create]
  resources :sick_leaves, only: [:index, :new, :create]
  resources :meetings, only: [:index]
  resources :attendances, only: [:index] do
    collection do
      get :all_attendance
    end
  end
  resources :qr_codes, only: [:create, :show]
  post 'qr_codes/scan', to: 'qr_codes#scan'
  

  namespace :admin do 
    resources :users, only: [:index, :new, :create, :show] do
      member do
        get 'reports', to: 'users#user_reports'
      end
    end
    resources :sick_leaves, only: [:index, :update] do
      member do
        patch :approve
        patch :reject
      end
    end
    resources :meetings, only: [:new, :index, :create]
    resources :attendances, only: [:new, :create, :index]
    resources :reports, only: [:index]
    resources :home, only: [:index]
  end

  resources :users, only: [:index]

  namespace :user do 
    resources :attendances, only: [:index, :new, :create]
  end
end
