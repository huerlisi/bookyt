Bookyt::Application.routes.draw do
  # Root
  root :to => "overview#index"

  match "/uploads/:model/:id/:basename.:extension", :controller => "attachments", :action => "download", :conditions => { :method => :get }

  # Authorization
  devise_for :users
  resources :users do
    collection do
      get :current
    end
  end

  # Accounting
  resources :account_types
  resources :banks

  resources :tenants do
    collection do
      get :current
    end
    member do
      get :balance_sheet, :profit_sheet
    end
    resources :attachments
  end
  resources :companies do
    resources :attachments
    member do
      get :new_phone_number
    end
    collection do
      get :new_phone_number
    end
  end

  # Attachments
  resources :attachments

  # Contacts
  resources :people do
    resources :attachments
    member do
      get :new_phone_number
    end
    collection do
      get :new_phone_number
    end
  end
  resources :employees do
    resources :attachments
    member do
      get :new_phone_number
    end
    collection do
      get :new_phone_number
    end
    resources :notes
  end
  resources :employments

  # Invoices
  resources :invoices do
    resources :attachments
    member do
      get :copy
    end
  end

  resources :credit_invoices do
    member do
      get :copy
    end

    resources :attachments
    member do
      get :new_line_item
    end
    collection do
      get :new_line_item
    end
  end

  resources :debit_invoices do
    member do
      get :letter
      get :copy
    end

    resources :attachments
    member do
      get :new_line_item
    end
    collection do
      get :new_line_item
    end
  end

  resources :customers do
    resources :invoices
    resources :attachments
    member do
      get :new_phone_number
    end
    collection do
      get :new_phone_number
    end
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
  resources :bank_accounts do
    member do
      get :csv_bookings
    end
    resources :bookings
  end

  # Imports
  resources :booking_imports

  # Notes
  resources :notes

  # Settings
  resources "settings" do
    collection do
      get :vesr
      post :vesr, :to => 'settings#update_vesr'
    end
  end

  resources :charge_rates
  resources :booking_templates
  resources :charge_booking_templates
end
