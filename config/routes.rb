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

  # Contacts
  resources :person
  resources :employees
  resources :employments
  
  # Invoices
  resources :invoices
  resources :credit_invoices
  resources :debit_invoices do
    member do
      get :letter
    end
  end
  
  resources :customers do
    resources :invoices
  end
  
  resources :direct_bookings
  
  resources :bookings do
    collection do
      post :select
    end
    member do
      get :select_booking, :select_booking_template
    end
  end
  
  resources :accounts do
    member do
      get :csv_bookings
    end
    resources :bookings
  end
  
  resources :booking_templates

  resources :booking_imports

  match '/balance' => 'balance#show'
  match '/profit' => 'profit#show'
  
  # Days
  resources :days do
    collection do
      post :calculate_cash
    end
  end
end
