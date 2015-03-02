class ApplicationController < ActionController::Base
  # Aspects
  protect_from_forgery

  # Set the user locale
  before_filter :set_locale
  def set_locale
    locale = params[:locale].presence || cookies[:locale].presence || I18n.default_locale
    I18n.locale = locale.to_s
    cookies[:locale] = locale unless (cookies[:locale] && cookies[:locale] == locale.to_s)
  end

  # Flash messages
  def interpolation_options
    begin
      { :resource_link => render_to_string(:partial => 'layouts/flash_new').html_safe }
    rescue
      {}
    end
  end

  # Mail
  before_filter :set_email_host
  def set_email_host
    ActionMailer::Base.default_url_options = {:host => request.host_with_port}
  end

  # Tenancy
  def current_tenant
    current_user.tenant
  end

  # https://gist.github.com/josevalim/fb706b1e933ef01e4fb6#file-1_unsafe_token_authenticatable-rb-L20
  # This is our new function that comes before Devise's one
  before_filter :authenticate_user_from_token!
  # This is Devise's authentication
  before_filter :authenticate_user!

  private

  # For this example, we are simply using token authentication
  # via parameters. However, anyone could use Rails's token
  # authentication features to get the token from a header.
  def authenticate_user_from_token!
    user_token = params[:user_token].presence
    user       = user_token && User.find_by_authentication_token(user_token.to_s)

    if user
      # Notice we are passing store false, so the user is not
      # actually stored in the session and a token is needed
      # for every request. If you want the token to work as a
      # sign in token, you can simply remove store: false.
      sign_in user, store: false
    end
  end
end
