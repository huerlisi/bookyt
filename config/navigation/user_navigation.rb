SimpleNavigation::Configuration.run do |navigation|

  # user navigation
  navigation.items do |primary|
    primary.item :logout, t('bookyt.main_navigation.new_user_session'), new_user_session_path, :highlights_on => /\/users\/sign_in/, :unless => Proc.new { user_signed_in? }
    primary.item :settings, t('bookyt.main_navigation.settings'), settings_path,
                 :tooltip => t('bookyt.main_navigation.tooltip.settings'),
                 :if => Proc.new { user_signed_in? } do |settings|
      settings.item :settings,                  t('bookyt.main_navigation.settings'), settings_path
      settings.item :divider_one,               "", :class => 'divider'
      settings.item :user_settings,             t('bookyt.settings.user.title'), user_path(current_user)
      settings.item :users_settings,            t('bookyt.settings.users.title'), users_path
      settings.item :tentant,                   t('bookyt.settings.tenant.title'), tenant_path(current_tenant)
      settings.item :divider_two,               "", :class => 'divider'
      settings.item :vesr_settings,             t('bookyt.settings.vesr.title'), vesr_settings_path
      settings.item :due,                       t('bookyt.settings.due.title'), '#'
      settings.item :divider_three,             "", :class => 'divider'
      settings.item :account_types,             t('bookyt.settings.account_types.title'), account_types_path
      settings.item :booking_templates,         t('bookyt.settings.booking_templates.title'), booking_templates_path
      settings.item :charge_booking_templates,  t('bookyt.settings.charge_booking_templates.title'), charge_booking_templates_path
      settings.item :charge_rates,              t('bookyt.settings.charge_rates.title'), charge_rates_path
      settings.item :divider_four,              "", :class => 'divider'
      settings.item :logout,                    t('bookyt.main_navigation.destroy_user_session'), destroy_user_session_path, :highlights_on => /\/users\/sign_out/, :if => Proc.new { user_signed_in? }
    end

    primary.dom_class = 'nav secondary-nav'
  end
end
