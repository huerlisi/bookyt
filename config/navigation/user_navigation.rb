SimpleNavigation::Configuration.run do |navigation|

  # user navigation
  navigation.items do |primary|
    primary.item :login, t('sessions.new.title'), '#', :highlights_on => /\/users\/sign_in/, :unless => Proc.new { user_signed_in? }
    primary.item :settings, t('bookyt.main_navigation.settings'), '#',
                 :if => Proc.new { user_signed_in? } do |settings|
      settings.item :users_settings,            t('bookyt.settings.users.title'), users_path
      if current_tenant
        settings.item :tentant,                   t('bookyt.settings.tenant.title'), tenant_path(current_tenant)
      end

      settings.item :divider_2,               "", :class => 'divider'
      settings.item :vesr_settings,             t('settings.vesr.title'), vesr_settings_path

      settings.item :divider_3,             "", :class => 'divider'
      settings.item :booking_templates,         t('bookyt.settings.booking_templates.title'), booking_templates_path

      settings.item :divider_4,             "", :class => 'divider'
      ['de-CH', 'nl-NL'].each do |locale|
        settings.item "template_#{locale}", locale, load_template_path(:template => { :locale => locale }), :method => :post
      end
    end

    primary.dom_class = 'nav secondary-nav'
  end
end
