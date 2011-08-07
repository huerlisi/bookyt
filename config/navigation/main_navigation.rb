# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  def account_item(parent, code)
    account = Account.find_by_code(code)
    return unless account

    parent.item "account_#{code}", account.to_s, account_path(account)
  end

  # Define the primary navigation
  navigation.items do |primary|
    # bookyt navigation
    primary.item :overview, t('bookyt.main_navigation.overview'), root_path,
                 :tooltip => t('bookyt.main_navigation.tooltip.overview'),
                 :if => Proc.new { user_signed_in? }

    # Hack to get engine navigations included
    Bookyt::Engine.setup_navigation(self, primary)

    primary.item :accounting, t('bookyt.main_navigation.accounting'), new_booking_path,
                 :tooltip => t('bookyt.main_navigation.tooltip.accounting'),
                 :if => Proc.new { user_signed_in? } do |accounting|
      accounting.item :booking, t('bookyt.main_navigation.new_booking'), new_booking_path,
                      :tooltip => t('bookyt.main_navigation.tooltip.new_booking'),
                      :highlights_on => /\/bookings\/.*$/
      accounting.item :balance, t('bookyt.main_navigation.balance'), balance_sheet_tenant_path(current_user.tenant, :by_value_period => params[:by_value_period]),
                      :tooltip => t('bookyt.main_navigation.tooltip.balance'),
                      :highlights_on => /#{Regexp.escape(balance_sheet_tenant_path(current_user.tenant))}($|\?)/
      accounting.item :profit, t('bookyt.main_navigation.profit'), profit_sheet_tenant_path(current_user.tenant, :by_value_period => params[:by_value_period]),
                      :tooltip => t('bookyt.main_navigation.tooltip.profit'),
                      :highlights_on => /#{Regexp.escape(profit_sheet_tenant_path(current_user.tenant))}($|\?)/
      accounting.item :accounts, t('bookyt.main_navigation.accounts'), accounts_path,
                      :tooltip => t('bookyt.main_navigation.tooltip.accounts'),
                      :highlights_on => /\/accounts/
      accounting.item :bookings, t('bookyt.main_navigation.bookings'), bookings_path,
                      :tooltip => t('bookyt.main_navigation.tooltip.bookings'),
                      :highlights_on => /\/bookings($|\?)/
      accounting.item :importer, t('bookyt.main_navigation.importer'), booking_imports_path,
                      :tooltip => t('bookyt.main_navigation.tooltip.importer'),
                      :highlights_on => /\/booking_imports/
    end

    primary.item :invoicing, t('bookyt.main_navigation.invoicing'), invoices_path,
                 :tooltip => t('bookyt.main_navigation.tooltip.invoicing'),
                 :if => Proc.new { user_signed_in? },
                 :highlights_on => /\/(credit_|debit_)?invoices.*/ do |invoicing|
      invoicing.item :invoices, t('bookyt.main_navigation.invoices'), invoices_path,
                     :tooltip => t('bookyt.main_navigation.tooltip.invoices'),
                     :highlights_on => /\/invoices$/
      invoicing.item :credit_invoices, t('bookyt.main_navigation.credit_invoices'), credit_invoices_path,
                     :highlights_on => /\/credit_invoices$/
      invoicing.item :new_credit_invoice, t('bookyt.main_navigation.new_credit_invoice'), new_credit_invoice_path,
                     :highlights_on => /\/credit_invoices\/new$/
      invoicing.item :debit_invoices, t('bookyt.main_navigation.debit_invoices'), debit_invoices_path,
                     :highlights_on => /\/debit_invoices$/
      invoicing.item :new_debit_invoice, t('bookyt.main_navigation.new_debit_invoice'), new_debit_invoice_path,
                     :highlights_on => /\/debit_invoices\/new$/
      invoicing.item :new_customer, t('bookyt.main_navigation.new_customer'), new_customer_path,
                     :tooltip => t('bookyt.main_navigation.tooltip.new_customer')
    end

    primary.item :contacts, t('bookyt.main_navigation.contacts'), people_path,
                 :tooltip => t('bookyt.main_navigation.tooltip.contacts'),
                 :if => Proc.new { user_signed_in? } do |contacts|
      contacts.item :people, t('bookyt.main_navigation.people'), people_path,
                             :tooltip => t('bookyt.main_navigation.tooltip.people'),
                             :highlights_on => /\/people($|\?|\/[0-9]*($|\?|\/.*))/
      contacts.item :employees, t('bookyt.main_navigation.employees'), employees_path,
                             :tooltip => t('bookyt.main_navigation.tooltip.employees'),
                             :highlights_on => /\/employees($|\?|\/[0-9]*($|\?|\/.*))/
      contacts.item :new_employee, t('bookyt.main_navigation.new_employee'), new_employee_path,
                             :tooltip => t('bookyt.main_navigation.tooltip.new_employee'),
                             :highlights_on => /\/employees\/new$/
      contacts.item :customers, t('bookyt.main_navigation.customers'), customers_path,
                             :tooltip => t('bookyt.main_navigation.tooltip.customers'),
                             :highlights_on => /\/customers($|\?|\/[0-9]*($|\?|\/.*))/
      contacts.item :new_customer, t('bookyt.main_navigation.new_customer'), new_customer_path,
                             :tooltip => t('bookyt.main_navigation.tooltip.new_customer'),
                             :highlights_on => /\/customers\/new$/
      contacts.item :companies, t('bookyt.main_navigation.companies'), companies_path,
                             :tooltip => t('bookyt.main_navigation.tooltip.companies'),
                             :highlights_on => /\/companies($|\?|\/[0-9]*($|\?|\/.*))/
    end

    primary.item :settings, t('bookyt.main_navigation.settings'), current_users_path,
                 :tooltip => t('bookyt.main_navigation.tooltip.settings'),
                 :if => Proc.new { user_signed_in? } do |settings|
      settings.item :current_user, t_title(:current, User), current_users_path,
                             :tooltip => t('bookyt.main_navigation.tooltip.current_user'),
                             :highlights_on => /\/users\/./
      settings.item :user_index, t_title(:index, User), users_path, :if => lambda { can?(:index, User) },
                             :tooltip => t('bookyt.main_navigation.tooltip.user_index'),
                             :highlights_on => /\/users$/
      settings.item :current_tenant, t_title(:current, Tenant), current_tenants_path, :if => lambda { can?(:current, current_user.tenant) },
                             :tooltip => t('bookyt.main_navigation.tooltip.current_tenant')
      settings.item :tenant_index, t_title(:index, Tenant), tenants_path, :if => lambda { can?(:index, Tenant) },
                             :tooltip => t('bookyt.main_navigation.tooltip.tenant_index'),
                             :highlights_on => /\/tenants($|\?)/
      settings.item :account_types, t('bookyt.main_navigation.account_types'), account_types_path,
                      :tooltip => t('bookyt.main_navigation.tooltip.account_types'),
                      :highlights_on => /\/account_types/
      settings.item :booking_templates, t_title(:index, BookingTemplate), booking_templates_path,
                             :highlights_on => /\/booking_templates($|\/[0-9]*($|\/.*))/
      settings.item :charge_booking_templates, t_title(:index, ChargeBookingTemplate), charge_booking_templates_path,
                             :highlights_on => /\/charge_booking_templates($|\/[0-9]*($|\/.*))/
      settings.item :charge_rates, t_title(:index, ChargeRate), charge_rates_path,
                             :highlights_on => /\/charge_rates(\/|$)/
    end
  end
end
