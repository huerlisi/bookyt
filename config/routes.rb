Bookyt::Application.routes.draw do
  # Root
  root :to => "overview#index"

  # I18n
  filter 'locale'

  # Tenancy
  devise_for :admin_users

  namespace :admin do
    match '/' => redirect('/admin/tenants')
    resources :tenants
  end

  get "setup" => "setup#tenant"
  scope 'setup' do
    get "accounting" => "setup#accounting"
    put "accounting" => "setup#accounting"
    get "select_template" => "setup#select_template"
    post "load_template" => "setup#load_template"
  end

  # static pages
  get 'imprint' => 'static_pages#imprint'

  # Authorization
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  resources :users

  # Search
  get "search" => "search#search"

  # Accounting
  resources :account_types

  resources :tenants, only: [:show, :update] do
    member do
      get :balance_sheet, :profit_sheet, :vat_report
    end
    resources :attachments
    resources :backups do
      collection do
        post :dump
      end
      member do
        post :restore
      end
    end
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

  resources :bookings_batch_edit, :only => [:index, :update]

  resources :direct_bookings

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
  resources :charge_booking_templates

  mount Bookyt::API => '/api'
end
