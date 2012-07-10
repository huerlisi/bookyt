class ApplicationController < ActionController::Base
  # Aspects
  protect_from_forgery

  # Authentication
  before_filter :authenticate_user!

  # Set the user locale
  before_filter :set_locale
  def set_locale
    locale = params[:locale] || cookies[:locale]
    I18n.locale = locale.to_s
    cookies[:locale] = locale unless (cookies[:locale] && cookies[:locale] == locale)
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
end
