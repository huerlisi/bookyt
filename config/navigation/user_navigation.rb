SimpleNavigation::Configuration.run do |navigation|

  # user navigation
  navigation.items do |primary|
    primary.item :logout, t('bookyt.main_navigation.destroy_user_session'), destroy_user_session_path, :highlights_on => /\/users\/sign_out/, :if => Proc.new { user_signed_in? }
    primary.item :logout, t('bookyt.main_navigation.new_user_session'), new_user_session_path, :highlights_on => /\/users\/sign_in/, :unless => Proc.new { user_signed_in? }
  end

end
