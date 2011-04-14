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

  # Attachments
  resources :attachments
  
  # Contacts
  resources :people
  resources :employees
  resources :employments
  
  # Invoices
  resources :invoices do
    resources :attachments
  end
  
  resources :credit_invoices do
    resources :attachments
  end
  
  resources :debit_invoices do
    member do
      get :letter
    end
    
    resources :attachments
  end
  
  resources :salaries
  
  resources :customers do
    resources :invoices
  end
  
  # Assets
  resources :assets
  resources :invoices do
    resources :assets
  end

  # Bookings
  resources :bookings do
    collection do
      post :select
    end
    member do
      get :select_booking, :select_booking_template
      get :copy
    end
  end
  
  resources :direct_bookings

  resources :accounts do
    member do
      get :csv_bookings
    end
    resources :bookings
  end
  
  # Booking templates
  resources :booking_templates
  resources :charge_booking_templates

  # Charge rates
  resources :charge_rates
  
  # Imports
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
