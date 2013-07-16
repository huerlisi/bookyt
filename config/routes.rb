Bookyt::Application.routes.draw do
  # Root
  root :to => "overview#index"

  # I18n
  filter 'locale'

  get "setup" => "setup#tenant"

  # Authorization
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  resources :users do
    collection do
      get :current
    end
  end

  # Search
  get "search" => "search#search"

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
  resources :attachments do
    member do
      get :download
    end
  end

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
  end
  resources :employments

  resources :banks do
    resources :attachments
    member do
      get :new_phone_number
    end
    collection do
      get :new_phone_number
    end
  end

  # Invoices
  resources :invoices do
    resources :simple_bookings
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
      get :new_company
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
      get :new_customer
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

  # Expenses
  get "expenses/new" => "expenses#new", :as => :new_expense
  get "expenses/new_vat" => "expenses#new_vat", :as => :new_vat_expense
  post "expenses" => "expenses#create", :as => :create_expense

  # Bookings
  resources :bookings do
    collection do
      post :select
      get :simple_edit
    end
    member do
      get :select_booking
      get :copy
    end
  end

  resources :direct_bookings

  resources :accounts do
    member do
      get :csv_bookings
    end
    resources :bookings
    resources :attachments
  end
  resources :bank_accounts do
    member do
      get :csv_bookings
    end
    resources :bookings
    resources :attachments
  end

  # Booking import
  resources :booking_imports
  resources :booking_import_attachments
  resources :mt940_imports
  resources :raiffeisen_csv_imports

  # Settings
  resources "settings" do
    collection do
      get :vesr
      post :vesr, :to => 'settings#update_vesr'
    end
  end

  resources :charge_rates
  resources :booking_templates do
    member do
      get :new_booking
    end
  end
  resources :charge_booking_templates
end
