def log_in(options={})
  @current_user = FactoryGirl.create(:user_admin, options)
  visit "/"
  fill_in "E-Mail", :with => @current_user.email
  fill_in "Passwort", :with => @current_user.password
  click_button "Anmelden"
end

def log_out
  visit "/"
  click_link "Logout"
end

# Sets users session directly to the application session,
# https://github.com/railsware/rack_session_access
def fast_log_in(options={})
  @current_user = FactoryGirl.create(:user_admin, options)
  page.set_rack_session('warden.user.user.key' => User.serialize_into_session(@current_user).unshift("User"))
end

def wait_for_ajax(timeout = 2)
  page.wait_until(timeout) do
    page.evaluate_script 'jQuery.active == 0'
  end
end
