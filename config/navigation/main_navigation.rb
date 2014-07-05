# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'
  navigation.autogenerate_item_ids = false

  def account_item(parent, code)
    account = Account.find_by_code(code)
    return unless account

    parent.item "account_#{code}", account.to_s, account_path(account)
  end

  # Define the primary navigation
  navigation.items do |primary|
    primary.item :accounting, t('bookyt.main_navigation.accounting'), '#' do |accounting|
      accounting.item :booking, t('bookyt.main_navigation.new_booking'), new_booking_path,
                      :highlights_on => /\/bookings\/.*$/
      accounting.item :booking, t('bookyt.main_navigation.new_expense'), new_expense_path
      accounting.item :accounting_divider, "", :class => 'divider'
      accounting.item :accounts, t_title(:index, Account), accounts_path
      accounting.item :bookings, t('bookyt.main_navigation.bookings'), bookings_path,
                      :highlights_on => /\/bookings($|\?)/
      if current_tenant
        accounting.item :balance, t('bookyt.main_navigation.balance'), balance_sheet_tenant_path(current_tenant, :by_value_period => params[:by_value_period]),
                        :highlights_on => /#{Regexp.escape(balance_sheet_tenant_path(current_tenant))}($|\?)/
        accounting.item :profit, t('bookyt.main_navigation.profit'), profit_sheet_tenant_path(current_tenant, :by_value_period => params[:by_value_period]),
                        :highlights_on => /#{Regexp.escape(profit_sheet_tenant_path(current_tenant))}($|\?)/
        accounting.item :divider, "", :class => 'divider'
        accounting.item :mt940_import, t_title(:import, BookingImportAttachment), new_booking_import_attachment_path
      end
    end

    primary.item :debit_invoices, t_title(:index, DebitInvoice), '#' do |invoicing|
      invoicing.item :new_debit_invoice, t_title(:new, DebitInvoice), new_debit_invoice_path
      invoicing.item :debit_invoices, t('bookyt.main_navigation.debit_invoices'), debit_invoices_path
      invoicing.item :divider, "", :class => 'divider'
      invoicing.item :new_esr_file, t('bookyt.main_navigation.new_esr_file'), new_esr_file_path
      invoicing.item :esr_files, t('bookyt.main_navigation.esr_files'), esr_files_path
    end

    primary.item :credit_invoices, t_title(:index, CreditInvoice), '#' do |invoicing|
      invoicing.item :new_credit_invoice, t_title(:new, CreditInvoice), new_credit_invoice_path
      invoicing.item :credit_invoices, t('bookyt.main_navigation.credit_invoices'), credit_invoices_path
    end

    primary.item :contacts, t('bookyt.main_navigation.contacts'), '#' do |contacts|
      contacts.item :people, t_title(:index, Person), people_path,
                             :highlights_on => /\/people($|\?|\/[0-9]*($|\?|\/.*))/
      contacts.item :employees, t_title(:index, Employee), employees_path,
                             :highlights_on => /\/employees($|\?|\/[0-9]*($|\?|\/.*))/
      contacts.item :customers, t_title(:index, Customer), customers_path,
                             :highlights_on => /\/customers($|\?|\/[0-9]*($|\?|\/.*))/
      contacts.item :companies, t_title(:index, Company), companies_path,
                             :highlights_on => /\/companies($|\?|\/[0-9]*($|\?|\/.*))/
      contacts.item :banks, t_title(:index, Bank), banks_path,
                             :highlights_on => /\/banks($|\?|\/[0-9]*($|\?|\/.*))/
    end

    # Hack to get engine navigations included
    Bookyt::Engine.setup_navigation(self, primary)
  end
end
