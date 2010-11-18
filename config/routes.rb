Bookyt::Application.routes.draw do
  # Root
  root :to => "overview#index"

  # Authorization
  devise_for :users
  resources :users do
    collection do
      get :current
    end
  end
  
  # Accounting
  resources :account_types

  resources :tenants do
    collection do
      get :current
    end
  end
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

  match '/balance' => 'balance#show'
  match '/profit' => 'profit#show'
  
  # Days
  resources :days do
    collection do
      post :calculate_cash
    end
  end
end
