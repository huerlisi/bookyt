# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|  
  # Define the primary navigation
  navigation.items do |primary|
    # bookyt navigation
    primary.item :overview, t('bookyt.main_navigation.overview'), root_path,
                 :tooltip => t('bookyt.main_navigation.tooltip.overview'),
                 :if => Proc.new { user_signed_in? }
    primary.item :store, t('bookyt.main_navigation.store'), new_day_path,
                 :tooltip => t('bookyt.main_navigation.tooltip.store'),
                 :if => Proc.new { user_signed_in? } do |store|
      store.item :day, t('bookyt.main_navigation.new_day'), new_day_path,
                 :tooltip => t('bookyt.main_navigation.tooltip.new_day'),
                 :highlights_on => /\/days/
    end

    primary.item :accounting, t('bookyt.main_navigation.accounting'), new_booking_path,
                 :tooltip => t('bookyt.main_navigation.tooltip.accounting'),
                 :if => Proc.new { user_signed_in? } do |accounting|
      accounting.item :booking, t('bookyt.main_navigation.new_booking'), new_booking_path,
                      :tooltip => t('bookyt.main_navigation.tooltip.new_booking'),
                      :highlights_on => /\/bookings\/.*$/
      accounting.item :balance, t('bookyt.main_navigation.balance'), balance_path,
                      :tooltip => t('bookyt.main_navigation.tooltip.balance')
      accounting.item :profit, t('bookyt.main_navigation.profit'), profit_path,
                      :tooltip => t('bookyt.main_navigation.tooltip.profit')
      accounting.item :accounts, t('bookyt.main_navigation.accounts'), accounts_path,
                      :tooltip => t('bookyt.main_navigation.tooltip.accounts'),
                      :highlights_on => /\/accounts/
      accounting.item :bookings, t('bookyt.main_navigation.bookings'), bookings_path,
                      :tooltip => t('bookyt.main_navigation.tooltip.bookings'),
                      :highlights_on => /\/bookings$/
    end

    primary.item :invoicing, t('bookyt.main_navigation.invoicing'), invoices_path,
                 :tooltip => t('bookyt.main_navigation.tooltip.invoicing'),
                 :if => Proc.new { user_signed_in? },
                 :highlights_on => /\/invoices.*/ do |invoicing|
      invoicing.item :invoices, t('bookyt.main_navigation.invoices'), invoices_path,
                     :tooltip => t('bookyt.main_navigation.tooltip.invoices'),
                     :highlights_on => /\/invoices$/      
      invoicing.item :new_invoice, t('bookyt.main_navigation.new_invoice'), new_invoice_path,
                     :tooltip => t('bookyt.main_navigation.tooltip.new_invoice'),
                     :highlights_on => /\/invoices\/new.*$/
    end

    primary.item :basic_claims_data, t('bookyt.main_navigation.basic_claims_data'), employees_path,
                 :tooltip => t('bookyt.main_navigation.tooltip.basic_claims_data'),
                 :if => Proc.new { user_signed_in? } do |basic_claims_data|
      basic_claims_data.item :employees, t('bookyt.main_navigation.employees'), employees_path,
                             :tooltip => t('bookyt.main_navigation.tooltip.employees'),
                             :highlights_on => /\/employees$/
      basic_claims_data.item :employers, t('bookyt.main_navigation.companies'), companies_path,
                             :tooltip => t('bookyt.main_navigation.tooltip.companies'),
                             :highlights_on => /\/companies$/
      basic_claims_data.item :customers, t('bookyt.main_navigation.customers'), customers_path,
                             :tooltip => t('bookyt.main_navigation.tooltip.customers'),
                             :highlights_on => /\/customers$/
    end

    primary.item :nav_users, t_model(User), users_path, :if => lambda { can?(:new, User) or can?(:index, User) } do |user|
      user.item :new_user, t_action(:new, User), new_user_path, :if => lambda { can?(:new, User) }
      user.item :user_index, t_action(:index, User), users_path, :if => lambda { can?(:index, User) }
    end

    primary.item :user_settings, t('bookyt.main_navigation.settings'), current_users_path,
                 :tooltip => t('bookyt.main_navigation.tooltip.settings'),
                 :if => Proc.new { user_signed_in? } do |settings|
      settings.item :current_user, t_title(:current, User), current_users_path
      settings.item :current_tenant, t_title(:current, Tenant), current_tenants_path, :if => lambda { can?(:current, current_user.tenant) }
    end
  end
end
