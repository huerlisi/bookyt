# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|  
  # Specify a custom renderer if needed. 
  # The default renderer is SimpleNavigation::Renderer::List which renders HTML lists.
  # The renderer can also be specified as option in the render_navigation call. 
  # navigation.renderer = Your::Custom::Renderer
  
  # Specify the class that will be applied to active navigation items. Defaults to 'selected'
  # navigation.selected_class = 'your_selected_class'
    
  # Item keys are normally added to list items as id.
  # This setting turns that off
  # navigation.autogenerate_item_ids = false
  
  # You can override the default logic that is used to autogenerate the item ids.
  # To do this, define a Proc which takes the key of the current item as argument.
  # The example below would add a prefix to each key.
  # navigation.id_generator = Proc.new {|key| "my-prefix-#{key}"}

  # The auto highlight feature is turned on by default.
  # This turns it off globally (for the whole plugin)
  # navigation.auto_highlight = false

  # Define the primary navigation
  navigation.items do |primary|
    # Add an item to the primary navigation. The following params apply:
    # key - a symbol which uniquely defines your navigation item in the scope of the primary_navigation
    # name - will be displayed in the rendered navigation. This can also be a call to your I18n-framework.
    # url - the address that the generated item links to. You can also use url_helpers (named routes, restful routes helper, url_for etc.)
    # options - can be used to specify attributes that will be included in the rendered navigation item (e.g. id, class etc.)
    #           some special options that can be set:
    #           :if - Specifies a proc to call to determine if the item should
    #                 be rendered (e.g. <tt>:if => Proc.new { current_user.admin? }</tt>). The
    #                 proc should evaluate to a true or false value and is evaluated in the context of the view.
    #           :unless - Specifies a proc to call to determine if the item should not
    #                     be rendered (e.g. <tt>:unless => Proc.new { current_user.admin? }</tt>). The
    #                     proc should evaluate to a true or false value and is evaluated in the context of the view.
    #           :method - Specifies the http-method for the generated link - default is :get.
    #           :highlights_on - if autohighlighting is turned off and/or you want to explicitly specify 
    #                            when the item should be highlighted, you can set a regexp which is matched 
    #                            against the current URI.
    #
    #primary.item :key_1, 'name', url, options
    
    # Add an item which has a sub navigation (same params, but with block)
    #primary.item :key_2, 'name', url, options do |sub_nav|
      # Add an item to the sub navigation (same params again)
      #sub_nav.item :key_2_1, 'name', url, options
    #end
  
    # You can also specify a condition-proc that needs to be fullfilled to display an item.
    # Conditions are part of the options. They are evaluated in the context of the views,
    # thus you can use all the methods and vars you have available in the views.
    #primary.item :key_3, 'Admin', url, :class => 'special', :if => Proc.new { current_user.admin? }
    #primary.item :key_4, 'Account', url, :unless => Proc.new { logged_in? }

    # you can also specify a css id or class to attach to this particular level
    # works for all levels of the menu
    # primary.dom_id = 'menu-id'
    # primary.dom_class = 'menu-class'
    
    # You can turn off auto highlighting for a specific level
    # primary.auto_highlight = false

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
      invoicing.item :new_invoice, t('bookyt.main_navigation.new_invoice'), new_invoice_path,
                     :tooltip => t('bookyt.main_navigation.tooltip.new_invoice'),
                     :highlights_on => /\/invoices\/new.*$/
      invoicing.item :invoices, t('bookyt.main_navigation.invoices'), invoices_path,
                     :tooltip => t('bookyt.main_navigation.tooltip.invoices'),
                     :highlights_on => /\/invoices$/
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

    primary.item :user_settings, t('bookyt.main_navigation.settings'), edit_user_registration_path,
                 :tooltip => t('bookyt.main_navigation.tooltip.settings'),
                 :if => Proc.new { user_signed_in? },
                 :highlights_on => /\/users\/edit/
  end
end
