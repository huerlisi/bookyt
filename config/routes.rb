Bookyt::Application.routes.draw do
  # Root
  root :to => "overview#index"

  # Authorization
  devise_for :users
  resources :users
  
  # Accounting
  resources :account_types

  resources :companies

  resources :employees
  resources :employments
  
  resources :invoices
  resources :customers do
    resources :invoices
  end
  
  resources :bookings do
    collection do
      post :select
    end
    member do
      get :select_booking, :select_booking_template
    end
  end
  
  resources :accounts do
    resources :bookings
  end
  
  resources :booking_templates

  resource :balance
  match '/profit' => 'profit#show'
  
  # Days
  resources :days
end
