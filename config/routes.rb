Bookyt::Application.routes.draw do
  # Root
  root :to => "overview#index"

  # Authorization
  devise_for :users
  
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
    member do
      post :select, :select_booking, :select_booking_template
      get :select, :select_booking, :select_booking_template
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
