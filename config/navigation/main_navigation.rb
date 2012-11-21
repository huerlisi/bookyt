# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  def account_item(parent, code)
    account = Account.find_by_code(code)
    return unless account

    parent.item "account_#{code}", account.to_s, account_path(account)
  end

  # Define the primary navigation
  navigation.items do |primary|
    primary.item :contacts, t('bookyt.main_navigation.contacts'), '#',
                 :tooltip => t('bookyt.main_navigation.tooltip.contacts'),
                 :if => Proc.new { user_signed_in? } do |contacts|
      contacts.item :people, t_title(:index, Person), people_path,
                             :tooltip => t('bookyt.main_navigation.tooltip.people'),
                             :highlights_on => /\/people($|\?|\/[0-9]*($|\?|\/.*))/
      contacts.item :employees, t_title(:index, Employee), employees_path,
                             :tooltip => t('bookyt.main_navigation.tooltip.employees'),
                             :highlights_on => /\/employees($|\?|\/[0-9]*($|\?|\/.*))/
      contacts.item :new_employee, t_title(:new, Employee), new_employee_path,
                             :tooltip => t('bookyt.main_navigation.tooltip.new_employee'),
                             :highlights_on => /\/employees\/new$/
      contacts.item :customers, t_title(:index, Customer), customers_path,
                             :tooltip => t('bookyt.main_navigation.tooltip.customers'),
                             :highlights_on => /\/customers($|\?|\/[0-9]*($|\?|\/.*))/
      contacts.item :new_customer, t_title(:new, Customer), new_customer_path,
                             :tooltip => t('bookyt.main_navigation.tooltip.new_customer'),
                             :highlights_on => /\/customers\/new$/
      contacts.item :companies, t_title(:index, Company), companies_path,
                             :tooltip => t('bookyt.main_navigation.tooltip.companies'),
                             :highlights_on => /\/companies($|\?|\/[0-9]*($|\?|\/.*))/
    end

    primary.item :accounting, t('bookyt.main_navigation.accounting'), '#',
                 :tooltip => t('bookyt.main_navigation.tooltip.accounting'),
                 :if => Proc.new { user_signed_in? } do |accounting|
      accounting.item :booking, t('bookyt.main_navigation.new_booking'), new_booking_path,
                      :tooltip => t('bookyt.main_navigation.tooltip.new_booking'),
                      :highlights_on => /\/bookings\/.*$/
      accounting.item :booking, t('bookyt.main_navigation.new_expense'), new_expense_path
      accounting.item :accounting_divider, "", :class => 'divider'
      accounting.item :accounts, t('bookyt.main_navigation.accounts'), accounts_path,
                      :tooltip => t('bookyt.main_navigation.tooltip.accounts'),
                      :highlights_on => /\/accounts/
      accounting.item :bookings, t('bookyt.main_navigation.bookings'), bookings_path,
                      :tooltip => t('bookyt.main_navigation.tooltip.bookings'),
                      :highlights_on => /\/bookings($|\?)/
      accounting.item :balance, t('bookyt.main_navigation.balance'), balance_sheet_tenant_path(current_user.tenant, :by_value_period => params[:by_value_period]),
                      :tooltip => t('bookyt.main_navigation.tooltip.balance'),
                      :highlights_on => /#{Regexp.escape(balance_sheet_tenant_path(current_user.tenant))}($|\?)/
      accounting.item :profit, t('bookyt.main_navigation.profit'), profit_sheet_tenant_path(current_user.tenant, :by_value_period => params[:by_value_period]),
                      :tooltip => t('bookyt.main_navigation.tooltip.profit'),
                      :highlights_on => /#{Regexp.escape(profit_sheet_tenant_path(current_user.tenant))}($|\?)/
      accounting.item :divider, "", :class => 'divider'
      accounting.item :mt940_import, t_title(:import, BookingImportAttachment), new_booking_import_attachment_path
      accounting.item :booking_imports, t_title(:import, BookingImport), new_booking_import_path
    end

    primary.item :invoicing, t('bookyt.main_navigation.invoicing'), '#',
                 :tooltip => t('bookyt.main_navigation.tooltip.invoicing'),
                 :if => Proc.new { user_signed_in? },
                 :highlights_on => /\/(credit_|debit_)?invoices.*/ do |invoicing|
      invoicing.item :credit_invoices, t('bookyt.main_navigation.credit_invoices'), credit_invoices_path,
                     :highlights_on => /\/credit_invoices$/
      invoicing.item :new_credit_invoice, t('bookyt.main_navigation.new_credit_invoice'), new_credit_invoice_path,
                     :highlights_on => /\/credit_invoices\/new$/
      invoicing.item :divider, "", :class => 'divider'
      invoicing.item :debit_invoices, t('bookyt.main_navigation.debit_invoices'), debit_invoices_path,
                     :highlights_on => /\/debit_invoices$/
      invoicing.item :new_debit_invoice, t('bookyt.main_navigation.new_debit_invoice'), new_debit_invoice_path,
                     :highlights_on => /\/debit_invoices\/new$/
      invoicing.item :divider, "", :class => 'divider'
      invoicing.item :new_esr_file, t('bookyt.main_navigation.new_esr_file'), new_esr_file_path
      invoicing.item :esr_files, t('bookyt.main_navigation.esr_files'), esr_files_path
    end

    # Hack to get engine navigations included
    Bookyt::Engine.setup_navigation(self, primary)
  end
end
